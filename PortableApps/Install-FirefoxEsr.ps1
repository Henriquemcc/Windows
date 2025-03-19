Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

# Download Variables
$url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
    "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
    "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64-aarch64"
}
else {
    throw "Invalid Architecture"
}
$downloadFileName = Get-FileNameFromUrl -Url:$url
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = [System.Collections.ArrayList]::new()
[void]$silentInstallArgs.Add("/S")

if (-not (Test-AdministratorPrivileges)) {
    $installationDirectory = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Mozilla Firefox")
    New-Item -Path $installationDirectory -ItemType Directory -ErrorAction SilentlyContinue
    [void]$silentInstallArgs.Add("/InstallDirectoryPath=`"$($installationDirectory)`"")
}

# Installing Firefox
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()