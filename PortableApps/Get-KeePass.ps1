$url = "https://sonik.dl.sourceforge.net/project/keepass/KeePass%202.x/2.50/KeePass-2.50.zip"

# Downloading KeePass
$downloadDestinationFilePath = [System.IO.Path]::Combine($env:TEMP, "KeePass-2.50.zip")
if (-not(Test-Path -Path:$downloadDestinationFilePath -PathType Leaf))
{
    Invoke-WebRequest -Uri:$url -OutFile:$downloadDestinationFilePath -UseBasicParsing
}

# Extracting KeePass
$extractDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "KeePass")
New-Item -Path:$extractDestinationPath -ItemType Directory -Force
Expand-Archive -Path:$downloadDestinationFilePath -DestinationPath:$extractDestinationPath -Force

# Creating Shortcut
$shortcutFilePath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "KeePass.lnk")
$executablePath = [System.IO.Path]::Combine($extractDestinationPath, "KeePass.exe")
New-Item -Path:$shortcutFilePath -ItemType SymbolicLink -Value:$executablePath -Force