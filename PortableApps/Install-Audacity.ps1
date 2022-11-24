# Download Variables
$url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
    "https://github.com/audacity/audacity/releases/download/Audacity-3.2.1/audacity-win-3.2.1-64bit.zip"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    "https://github.com/audacity/audacity/releases/download/Audacity-3.2.1/audacity-win-3.2.1-32bit.zip"
}
else {
    throw "Invalid Architecture"
}
$downloadFilePath = [System.IO.Path]::Combine($env:TMP, [System.IO.Path]::GetFileName($url))

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Audacity")

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Extracting Audacity
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shotcut Variables
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Audacity.lnk")
$executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object { $_.BaseName.Contains("audacity-win") })[0].FullName, "Audacity.exe")

# Creating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()