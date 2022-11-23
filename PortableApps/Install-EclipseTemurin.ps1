param (
    # JDK Version
    [Parameter(Mandatory = $false)][System.Int16]$Version = 8
)

function GetEclipseTemurinUrl {
    param (
        # JDK Version
        [Parameter(Mandatory = $false)][System.Int16]$Version = 8
    )

    if ($Version -eq 8) {
        if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
            return "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jdk_x64_windows_hotspot_8u352b08.zip"
        }
        elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
            return "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u352-b08/OpenJDK8U-jdk_x86-32_windows_hotspot_8u352b08.zip"
        }
        else {
            throw "Invalid Architecture"
        }
    }
    elseif ($Version -eq 11) {
        if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
            return "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.17%2B8/OpenJDK11U-jdk_x64_windows_hotspot_11.0.17_8.zip"
        }
        elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
            return "https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.17%2B8/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.17_8.zip"
        }
        else {
            throw "Invalid Architecture"
        }
    }
    elseif ($Version -eq 17) {
        if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
            return "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jdk_x64_windows_hotspot_17.0.5_8.zip"
        }
        elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
            return "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.5_8.zip"
        }
        else {
            throw "Invalid Architecture"
        }
    }
}

# Download Variables
$url = GetEclipseTemurinUrl -Version:$Version
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Installation Varibles
$installationDirectoryPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", [System.IO.Path]::GetFileNameWithoutExtension($downloadFileName))

# Downloading Eclipse Temurin
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Directory
New-Item -Path:$installationDirectoryPath -ItemType Directory -ErrorAction SilentlyContinue

# Extracting Eclipse Temurin
Expand-Archive -Path:$downloadFilePath -DestinationPath:$installationDirectoryPath

# Adding to path
$javaHomePath = (Get-ChildItem -Path:$installationDirectoryPath -Directory | Where-Object {$_.BaseName.Contains("jdk")})[0].FullName
$binFolderPath = [System.IO.Path]::Combine($javaHomePath, "bin")

$envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
if ($envPath.Length -gt 0 -and (-not $envPath.EndsWith(";")))
{
    $envPath += ";"
}
$envPath += $binFolderPath
[System.Environment]::SetEnvironmentVariable("Path", $envPath, [System.EnvironmentVariableTarget]::User)