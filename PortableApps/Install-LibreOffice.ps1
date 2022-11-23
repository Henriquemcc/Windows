Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))

# Download Variables
$url = "https://download.documentfoundation.org/libreoffice/portable/7.4.2/LibreOfficePortable_7.4.2_MultilingualAll.paf.exe"
$downloadFileName = Get-FileNameFromUrl -Url:$url
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
Write-Host $downloadFilePath

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installing LibreOffice
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()