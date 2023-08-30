$ErrorActionPreference = "Stop"

function Abort {
    param([string]$message)
    Write-Host $message -ForegroundColor Red
    exit 1
}

function Ohai {
    param([string]$message)
    Write-Host "==>$message" -ForegroundColor Cyan
}

$OS = [System.Environment]::OSVersion.Platform.ToString()
if ($OS -ne "Win32NT") {
    Abort "mcli is only supported on Windows."
}

$MCLI_PREFIX = $Env:USERPROFILE
$MCLI_REPOSITORY = Join-Path $MCLI_PREFIX ".mcli"

function Execute {
    param([string]$command, [string[]]$arguments)
    $process = Start-Process -FilePath $command -ArgumentList $arguments -PassThru -Wait
    if ($process.ExitCode -ne 0) {
        Abort ("Failed during: " + $command + " " + ($arguments -join " "))
    }
}

####################################################################### script
Ohai "This script will install:"
Write-Host $MCLI_REPOSITORY

if (Test-Path $MCLI_REPOSITORY) {
    Abort ("mcli is already installed in " + $MCLI_REPOSITORY + ".")
}

New-Item -Path $MCLI_REPOSITORY -ItemType Directory | Out-Null

Ohai "Downloading and installing mcli..."
$null = Set-Location $MCLI_REPOSITORY

Execute "git" "-c" "init.defaultBranch=main" "init" "--quiet"

$null = & git config remote.origin.url $MCLI_DEFAULT_GIT_REMOTE
$null = & git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

Execute "git" "fetch" "--force" "origin"
Execute "git" "reset" "--hard" "origin/main"

$MCLI_BIN = Join-Path $MCLI_PREFIX "bin"
$null = New-Item -Path $MCLI_BIN -ItemType Directory

Copy-Item -Path (Join-Path $MCLI_REPOSITORY "bin\mcli") -Destination (Join-Path $MCLI_BIN "mcli")

Ohai "Installing python virtual environment..."
$null = Set-Location $MCLI_REPOSITORY

Execute "python" "-m" "venv" (Join-Path $MCLI_REPOSITORY ".venv")
Execute (Join-Path $MCLI_REPOSITORY ".venv\Scripts\pip") "--disable-pip-version-check" "install" "-r" (Join-Path $MCLI_REPOSITORY "requirements.txt")

if ($env:PATH -notlike "*$MCLI_BIN*") {
    Write-Warning "$MCLI_BIN is not in your PATH."
}

Ohai "Installation successful!"
