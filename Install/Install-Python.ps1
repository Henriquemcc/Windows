Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-Expression.ps1"))

# Installing from Microsoft Store
Invoke-Expression -Command "winget install 9NRWMJP3717K --source msstore --silent --accept-source-agreements --accept-package-agreements"

# Downloading and installing its executable file
if ((-not (Test-Expression -Command "winget")) -or ($LASTEXITCODE -ne 0)) {

    # Download Variables
    $baseUrl = "https://www.python.org/ftp/python/"
    $version = "3.11.4"
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "$($baseUrl)$($version)/python-$($version)-amd64.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "$($baseUrl)$($version)/python-$($version).exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        "$($baseUrl)$($version)/python-$($version)-arm64.exe"
    }
    else {
        throw "Invalid Architecture"
    }
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = [System.Collections.ArrayList]::new()
    [void]$silentInstallArgs.Add("/quiet")

    if (Test-AdministratorPrivileges) {
        [void]$silentInstallArgs.Add("InstallAllUsers=1")
    }
    else {
        [void]$silentInstallArgs.Add("InstallAllUsers=0")
    }

    [void]$silentInstallArgs.Add("PrependPath=1")
    [void]$silentInstallArgs.Add("AppendPath=1")

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
}