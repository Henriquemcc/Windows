function GetPaintDotNetUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://github.com/paintdotnet/release/releases/download/v4.3.12/paint.net.4.3.12.portable.x64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://github.com/paintdotnet/release/releases/download/v4.3.12/paint.net.4.3.12.portable.x86.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        return "https://github.com/paintdotnet/release/releases/download/v4.3.12/paint.net.4.3.12.portable.arm64.zip"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = GetPaintDotNetUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Paint.net")

# Extracting Paint.net
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shotcut Variables
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Paint.net.lnk")
$executablePath = [System.IO.Path]::Combine($installationDirectoryPath, "paintdotnet.exe")

# Creating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()