$url = "https://github.com/Henriquemcc/Windows/archive/refs/heads/main.zip"
$downloadFileName = "Windows-main.zip"
$downloadFilePath = [System.IO.Path]::Combine($env:APPDATA, $downloadFileName)
Invoke-WebRequest -Uri $url -OutFile $downloadFilePath
Expand-Archive -Path $downloadFilePath -DestinationPath $env:APPDATA -Force
$directory = [System.IO.Path]::Combine($env:APPDATA, $downloadFileName.Substring(0, $downloadFileName.Length - ".zip".Length))
Set-Location -Path $directory
.\Main.ps1