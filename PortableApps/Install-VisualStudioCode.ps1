Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))

function Get-VisualStudioCodeUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://az764295.vo.msecnd.net/stable/8fa188b2b301d36553cbc9ce1b0a146ccb93351f/VSCodeUserSetup-x64-1.73.0.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://az764295.vo.msecnd.net/stable/8fa188b2b301d36553cbc9ce1b0a146ccb93351f/VSCodeUserSetup-ia32-1.73.0.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        return "https://az764295.vo.msecnd.net/stable/8fa188b2b301d36553cbc9ce1b0a146ccb93351f/VSCodeUserSetup-arm64-1.73.0.exe"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = Get-VisualStudioCodeUrl
$downloadFileName = Get-FileNameFromUrl -Url:$url
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = @("/verysilent", "/suppressmsgboxes")

# Installing Visual Studio Code
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()