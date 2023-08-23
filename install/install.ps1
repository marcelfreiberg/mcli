$profileDirectory = $env:USERPROFILE
$installDirectory = "$profileDirectory\.mcli"

####################################################################### script
Write-Host "This script will install:"
Write-Host " ${installDirectory} - mcli"

Create-Item -Path $installDirectory -ItemType Directory -Force

Write-Host "Downloading and installing mcli..."

# $directoryToAdd = "C:\Users\<Username>\AppData\Local\Programs\<mcli-install-directory>"
# [System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$directoryToAdd", [System.EnvironmentVariableTarget]::User)
