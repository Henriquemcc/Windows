Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

# Download Variables
$url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
    "https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    "https://download-chromium.appspot.com/dl/Win?type=snapshots"
}
else {
    throw "Invalid Architecture"
}
$dateString = "$([System.DateTime]::Now.Year)-$([System.DateTime]::Now.Month)-$([System.DateTime]::Now.Day)_$([System.DateTime]::Now.Hour)-$([System.DateTime]::Now.Minute)-$([System.DateTime]::Now.Second)-$([System.DateTime]::Now.Millisecond)"
$downloadFileName = "chrome-win_$dateString.zip"
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Installation Varibles
$installationDirectoryPath = if (Test-AdministratorPrivileges) {
    [System.IO.Path]::Combine($env:ProgramFiles, "Chromium")
}
else {
    [System.IO.Path]::Combine($env:APPDATA, "Programs", "Chromium")
}

# Shotcut Variables
$executablePath = [System.IO.Path]::Combine($installationDirectoryPath, "chrome-win", "chrome.exe")

$normalShortcutDestinationPath = if (Test-AdministratorPrivileges) {
    [System.IO.Path]::Combine($env:ProgramData, "Microsoft", "Windows", "Start Menu", "Programs", "Chromium.lnk") 
}
else {
    [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Chromium.lnk") 
}

$guestShortcutDestinationPath = if (Test-AdministratorPrivileges) {
    [System.IO.Path]::Combine($env:ProgramData, "Microsoft", "Windows", "Start Menu", "Programs", "Chromium Guest.lnk")
}
else {
    [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Chromium Guest.lnk")
}

# Downloading Chromium
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Extracting Chromium
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Creating Shortcut Normal
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($normalShortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()
$shortcut = $null

# Creating Shortcut Guest
$shortcut = $WScriptShell.CreateShortcut($guestShortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Arguments = "--guest"
$shortcut.Save()