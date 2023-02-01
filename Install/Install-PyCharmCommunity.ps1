Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

# Download Variables
$url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64" -or $env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    "https://download.jetbrains.com/python/pycharm-professional-2022.3.2.exe"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
    "https://download.jetbrains.com/python/pycharm-professional-2022.3.2-aarch64.exe"
}
else {
    throw "Invalid Architecture"
}
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Configuration File
$configurationFilePath = [System.IO.Path]::Combine($env:TMP, "silent.config")
$configurationFileString = [System.Text.StringBuilder]::new()

if (-not (Test-AdministratorPrivileges)) {
    $configurationFileString.AppendLine("mode=user")   
}
else {
    $configurationFileString.AppendLine("mode=admin")
}

if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64" -or $env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
    $configurationFileString.AppendLine("launcher32=0")
    $configurationFileString.AppendLine("launcher64=1")
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
    $configurationFileString.AppendLine("launcher32=1")
    $configurationFileString.AppendLine("launcher64=0")
}
$configurationFileString.AppendLine("updatePATH=1")
$configurationFileString.AppendLine("updateContextMenu=0")
$configurationFileString.AppendLine("jre32=0")
$configurationFileString.AppendLine("regenerationSharedArchive=1")
$configurationFileString.AppendLine(".py=0")
$configurationFile = [System.IO.File]::Open([System.IO.Path]::Combine($configurationFilePath), [System.IO.FileAccess]::Write)
$configurationFileStream = [System.IO.StreamWriter]::new($configurationFile)
$configurationFileStream.Write($configurationFileString.ToString())
$configurationFileStream.Close()

# Installation variables
$silentInstallArgs = @("/S", "/CONFIG=`"$configurationFilePath`"")

# Installing IntelliJ
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()