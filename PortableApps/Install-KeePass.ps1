Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -Parent), "functions", "Util", "Get-FileNameFromUrl.ps1"))

# Download Variables
$url = "https://sonik.dl.sourceforge.net/project/keepass/KeePass%202.x/2.52/KeePass-2.52.zip"
$downloadFileName = Get-FileNameFromUrl -Url:$url
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "KeePass")

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Extracting KeePass
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shortcut Variables
$executablePath = [System.IO.Path]::Combine($installationDirectoryPath, "KeePass.exe")
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "KeePass.lnk")

# Crating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($ShortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()
