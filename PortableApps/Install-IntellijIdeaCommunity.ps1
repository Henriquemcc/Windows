# Download Variables
$url = "https://download.jetbrains.com/idea/ideaIC-2022.2.3.exe"
$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
#Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Creating Installation Configuration File
$configurationFilePath = [System.IO.Path]::Combine($env:TMP, "silent.config")
$configurationFileString = [System.Text.StringBuilder]::new()
$configurationFileString.Append("mode=user")
$configurationFile = [System.IO.File]::Open([System.IO.Path]::Combine($configurationFilePath), [System.IO.FileAccess]::Write)
$configurationFileStream = [System.IO.StreamWriter]::new($configurationFile)
$configurationFileStream.Write($configurationFileString.ToString())
$configurationFileStream.Close()

# Installation variables
$silentInstallArgs = @("/S", "/CONFIG=`"$configurationFilePath`"")

# Creating Installation Directory
#New-Item -Path:$installationDirectory -ItemType Directory

# Installing IntelliJ
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()