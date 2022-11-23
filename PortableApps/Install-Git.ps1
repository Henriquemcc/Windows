function Get-GitUrl {
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        return "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        return "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-32-bit.exe"
    }
    else {
        throw "Invalid Architecture"
    }
}

# Download Variables
$url = Get-GitUrl
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = @("/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/GitAndUnixToolsOnPath", "/WindowsTerminalProfile")

# Installing Git
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()