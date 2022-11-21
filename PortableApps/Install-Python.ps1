function GetPythonUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://www.python.org/ftp/python/3.11.0/python-3.11.0.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        return "https://www.python.org/ftp/python/3.11.0/python-3.11.0-arm64.exe"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = GetPythonUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = @("/quiet", "InstallAllUsers=0", "PrependPath=1", "AppendPath=1")

# Installing Python
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()

# Deleting Windows Store Python 3
$windowsStorePythonPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "python3.exe")
Remove-Item -Path:$windowsStorePythonPath

# Deleting Windows Store Python
$windowsStorePythonPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "python.exe")
Remove-Item -Path:$windowsStorePythonPath