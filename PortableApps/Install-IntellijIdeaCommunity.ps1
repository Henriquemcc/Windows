# Download Variables
$url = "https://download.jetbrains.com/idea/ideaIC-2022.2.3.exe"
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Configuration File
$configurationFilePath = [System.IO.Path]::Combine($env:TMP, "silent.config")
$configurationFileString = [System.Text.StringBuilder]::new()
$configurationFileString.AppendLine("mode=user")
if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
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
$configurationFileString.AppendLine(".java=0")
$configurationFileString.AppendLine(".groovy=0")
$configurationFileString.Append(".kt=0")
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