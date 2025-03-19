# Installing requirements

## VC Libs
$vcLibsUrl = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
    "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
    "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm") {
    "https://aka.ms/Microsoft.VCLibs.arm.14.00.Desktop.appx"
}

### Downloading
$downloadFileName = [System.IO.Path]::GetFileName($vcLibsUrl)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
Invoke-WebRequest -Uri:$vcLibsUrl -OutFile:$downloadFilePath

### Installing
Add-AppxPackage -Path:$downloadFilePath

## Microsoft Desktop App Installer
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

# Installing Winget
$wingetUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

## Downloading
$downloadFileName = [System.IO.Path]::GetFileName($wingetUrl)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
Invoke-WebRequest -Uri:$wingetUrl -OutFile:$downloadFilePath

## Installing
Add-AppxPackage -Path:$downloadFilePath