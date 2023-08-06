#!/bin/bash

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

ohai() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

OS="$(uname)"
# if [[ "${OS}" == "Linux" ]]
if ! [[ "${OS}" == "Darwin" ]]
then
  abort "mcli is only supported on macOS."
fi

# USER isn't always set so provide a fall back for the installer and subprocesses.
if [[ -z "${USER-}" ]]
then
  USER="$(chomp "$(id -un)")"
  export USER
fi

# Installation variables for macos
MCLI_PREFIX="/usr/local"
MCLI_REPOSITORY="${MCLI_PREFIX}/mcli"
CHOWN=("/usr/sbin/chown")
GROUP="admin"

# Common installation variables
CHMOD=("/bin/chmod")
MKDIR=("/bin/mkdir" "-p")
GIT=/usr/bin/git
MCLI_DEFAULT_GIT_REMOTE="https://github.com/marcelfreiberg/mcli"

unset HAVE_SUDO_ACCESS # unset this from the environment

have_sudo_access() {
  if [[ ! -x "/usr/bin/sudo" ]]
  then
    return 1
  fi

  local -a SUDO=("/usr/bin/sudo")
  if [[ -n "${SUDO_ASKPASS-}" ]]
  then
    SUDO+=("-A")
  elif [[ -n "${NONINTERACTIVE-}" ]]
  then
    SUDO+=("-n")
  fi

  if [[ -z "${HAVE_SUDO_ACCESS-}" ]]
  then
    if [[ -n "${NONINTERACTIVE-}" ]]
    then
      "${SUDO[@]}" -l mkdir &>/dev/null
    else
      "${SUDO[@]}" -v && "${SUDO[@]}" -l mkdir &>/dev/null
    fi
    HAVE_SUDO_ACCESS="$?"
  fi

  if [[ "${HAVE_SUDO_ACCESS}" -ne 0 ]]
  then
    abort "Need sudo access on macOS (e.g. the user ${USER} needs to be an Administrator)!"
  fi

  return "${HAVE_SUDO_ACCESS}"
}

execute() {
  if ! "$@"
  then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

execute_sudo() {
  local -a args=("$@")
  if have_sudo_access
  then
    if [[ -n "${SUDO_ASKPASS-}" ]]
    then
      args=("-A" "${args[@]}")
    fi
    ohai "/usr/bin/sudo" "${args[@]}"
    execute "/usr/bin/sudo" "${args[@]}"
  else
    ohai "${args[@]}"
    execute "${args[@]}"
  fi
}

check_run_command_as_root() {
  [[ "${EUID:-${UID}}" == "0" ]] || return
  abort "Don't run this as root!"
}

####################################################################### script
ohai 'Checking for `sudo` access (which may request your password)...'
have_sudo_access
check_run_command_as_root

ohai "This script will install:"
echo "${MCLI_PREFIX}/bin/mcli"
echo "${MCLI_REPOSITORY}"

if [[ -d "${MCLI_REPOSITORY}" ]]
then
    abort "mcli is already installed in ${MCLI_REPOSITORY}."
fi
execute_sudo "${MKDIR[@]}" "${MCLI_REPOSITORY}"
execute_sudo "${CHOWN[@]}" "-R" "${USER}:${GROUP}" "${MCLI_REPOSITORY}"

ohai "Downloading and installing mcli..."
(
    cd "${MCLI_REPOSITORY}" >/dev/null || return

    # we do it in four steps to avoid merge errors when reinstalling
    execute "${USABLE_GIT}" "-c" "init.defaultBranch=main" "init" "--quiet"

    # "git remote add" will fail if the remote is defined in the global config
    execute "${USABLE_GIT}" "config" "remote.origin.url" "${MCLI_DEFAULT_GIT_REMOTE}"

    execute "${USABLE_GIT}" "fetch" "--force" "origin"

    execute "${USABLE_GIT}" "reset" "--hard" "origin/master"

    execute "ln" "-sf" "../mcli/bin/mcli.py" "${MCLI_PREFIX}/bin/mcli"
) || exit 1

if [[ ":${PATH}:" != *":${MCLI_PREFIX}/bin:"* ]]
then
  warn "${MCLI_PREFIX}/bin is not in your PATH."
fi

ohai "Installation successful!"
echo