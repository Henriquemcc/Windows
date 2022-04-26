$url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64")
{
    "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86")
{
    "https://code.visualstudio.com/sha/download?build=stable&os=win32-archive"
}
elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64")
{
    "https://code.visualstudio.com/sha/download?build=stable&os=win32-arm64-archive"
}

# Downloading Visual Studio Code
$downloadDestinationFilePath = [System.IO.Path]::Combine($env:TEMP, "VSCode.zip")
if (-not(Test-Path -Path:$downloadDestinationFilePath -PathType Leaf))
{
    Invoke-WebRequest -Uri:$url -OutFile:$downloadDestinationFilePath -UseBasicParsing
}

# Extracting Visual Studio Code
$extractDestinationPath = [System.IO.Path]::Combine($env:APPDATA, "Visual Studio Code")
New-Item -Path:$extractDestinationPath -ItemType Directory -Force
Expand-Archive -Path:$downloadDestinationFilePath -DestinationPath:$extractDestinationPath -Force

# Creating Shortcut
$shortcutFilePath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft", "Windows", "Start Menu", "Programas", "Visual Studio Code.lnk")
$visualStudioCodeExecutablePath = [System.IO.Path]::Combine($extractDestinationPath, "Code.exe")
New-Item -Path:$shortcutFilePath -ItemType SymbolicLink -Value:$visualStudioCodeExecutablePath -Force