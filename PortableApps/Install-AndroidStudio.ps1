function GetAndroidStudioUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.17/android-studio-2021.3.1.17-windows.zip"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = GetAndroidStudioUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Android Studio")

# Extracting Android Studio
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Shotcut Variables
$shortcutDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Android Studio.lnk")
$executablePath = [System.IO.Path]::Combine((Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object {$_.BaseName.Contains("android-studio")})[0].FullName, "bin", "studio64.exe")

# Creating Shortcut
$WScriptShell = New-Object -ComObject "WScript.Shell"
$shortcut = $WScriptShell.CreateShortcut($shortcutDestinationPath)
$shortcut.TargetPath = $executablePath
$shortcut.Save()