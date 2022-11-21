function GetKeePassXcUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://github.com/keepassxreboot/keepassxc/releases/download/2.7.4/KeePassXC-2.7.4-Win64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://github.com/keepassxreboot/keepassxc/releases/download/2.6.6/KeePassXC-2.6.6-Win32-portable.zip"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = GetKeePassXcUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "KeePassXC")

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Extracting KeePassXc
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shortcut Variables
$executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object {$_.BaseName.Contains("KeePassXC")})[0].FullName, "KeePassXC.exe")
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "KeePassXC.lnk")

# Crating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($ShortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()