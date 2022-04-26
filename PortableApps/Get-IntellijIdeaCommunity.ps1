$url = "https://download.jetbrains.com/idea/ideaIC-2022.1.win.zip"

# Downloading IntelliJ idea
$downloadDestinationFilePath = [System.IO.Path]::Combine($env:TEMP, "ideaIC.zip")
if (-not(Test-Path -Path:$downloadDestinationFilePath -PathType Leaf))
{
    Invoke-WebRequest -Uri:$url -OutFile:$downloadDestinationFilePath -UseBasicParsing
}

# Extracting IntelliJ
$extractDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "IntelliJ IDEA Community")
New-Item -Path:$extractDestinationPath -ItemType Directory -Force
Expand-Archive -Path:$downloadDestinationFilePath -DestinationPath:$extractDestinationPath -Force

# Creating Shortcut
$shortcutFilePath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "IntelliJ IDEA Community.lnk")
$intellijIdeaExecutablePath = [System.IO.Path]::Combine($extractDestinationPath, "bin", "idea64.exe")
New-Item -Path:$shortcutFilePath -ItemType SymbolicLink -Value:$intellijIdeaExecutablePath -Force