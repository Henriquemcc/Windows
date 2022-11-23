Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))

function Get-FirefoxEsrUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        return "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64-aarch64"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = Get-FirefoxEsrUrl
$downloadFileName = Get-FileNameFromUrl -Url:$url
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$installationDirectory = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Mozilla Firefox")
$silentInstallArgs = @("/S", "/InstallDirectoryPath=`"$($installationDirectory)`"")

# Installing Firefox
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()