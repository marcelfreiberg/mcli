#!/bin/bash

set -u

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

quiet_cd() {
    cd "$@" &>/dev/null || return
}

# string formatters
if [[ -t 1 ]]
then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

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

ohai "Updating mcli"