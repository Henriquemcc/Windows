Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

# Download Variables
$url = "https://github.com/nomacs/nomacs/releases/latest/download/nomacs-setup-x64.exe"
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = [System.Collections.ArrayList]::new()
[void]$silentInstallArgs.Add("/VERYSILENT")
[void]$silentInstallArgs.Add("/SUPPRESSMSGBOXES")

if (-not (Test-AdministratorPrivileges)) {
    [void]$silentInstallArgs.Add("/CURRENTUSER")
}

[void]$silentInstallArgs.Add("/NORESTART")

# Installing Nomacs
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()