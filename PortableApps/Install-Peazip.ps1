function GetPeazipUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://github.com/peazip/PeaZip/releases/download/8.9.0/peazip_portable-8.9.0.WIN64.zip"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://github.com/peazip/PeaZip/releases/download/8.9.0/peazip_portable-8.9.0.WINDOWS.zip"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = GetPeazipUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Peazip")

# Extracting Peazip
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shotcut Variables
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Peazip.lnk")
$executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object {$_.BaseName.Contains("peazip_portable")})[0].FullName, "peazip.exe")

# Creating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()