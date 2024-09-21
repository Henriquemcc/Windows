﻿# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Instalando Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Obtendo a localização do Winget
$winget = (Get-Command -Name winget).Source
if ($null -eq $winget)
{
    $winget = ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))
}

# Atualizando programas
& $winget upgrade --silent --all

# Desinstalando programas
$programasRemoverWinget = @('Microsoft.OneDrive',
'9NBLGGH5R558', # Microsoft To Do
'9NBLGGH4QGHW', # Microsoft Sticky Notes
'9P1J8S7CCWWT', # Microsoft Clipchamp
'9WZDNCRFHVFW' # Microsoft Notícias
)
foreach ($programa in $programasRemoverWinget)
{
    & $winget uninstall --silent --id "$programa"
}

# Instalando programas
$programasInstalarWinget = @('Mozilla.Firefox.ESR', 'Google.Chrome', 'Bitwarden.Bitwarden', 'Spotify.Spotify', 'Microsoft.Teams', 'OpenWhisperSystems.Signal', '7zip.7zip', 'VideoLAN.VLC', 'EclipseAdoptium.Temurin.21.JDK', 'EclipseAdoptium.Temurin.8.JDK', 'Python.Python.3.12', 'Microsoft.VisualStudioCode', 'Git.Git', 'JetBrains.IntelliJIDEA.Community', 'JetBrains.PyCharm.Community', 'Microsoft.WindowsTerminal', 'Microsoft.VisualStudio.2022.Community', 'TheDocumentFoundation.LibreOffice', 'Adobe.Acrobat.Reader.64-bit', 'Discord.Discord', 'GIMP.GIMP', 'Oracle.VirtualBox', 'Giorgiotani.Peazip', 'WireGuard.WireGuard', 'Microsoft.BingWallpaper', 'Discord.Discord', 'Audacity.Audacity', 'gerardog.gsudo', 'Rclone.Rclone', 'GitHub.cli', 'Microsoft.Skype', 'Valve.Steam', 'ElectronicArts.EADesktop', 'EpicGames.EpicGamesLauncher', 'Ubisoft.Connect', 'DominikReichl.KeePass', 'Rufus.Rufus', 'JGraph.Draw', 'Oracle.MySQLWorkbench', 'Nvidia.CUDA', 'Nvidia.GeForceExperience', 'PuTTY.PuTTY', 'HARMAN.AdobeAIR', 'JetBrains.CLion', 'DominikReichl.KeePass ', 'Insecure.Nmap', 'OBSProject.OBSStudio', 'qBittorrent.qBittorrent', 'Python.Launcher', 'Cisco.Webex', 'Gyan.FFmpeg', 'Postman.Postman', 'Stremio.Stremio', 'JetBrains.Toolbox', 'KDE.Kdenlive', 'yt-dlp.yt-dlp', 'Debian.Debian')
foreach ($programa in $programasInstalarWinget)
{
    & $winget install --silent --id "$programa" --source winget
}

# Instalando programas da Microsoft Store
$programasInstalarWindowsStore = @(
    '9WZDNCRFHWLH', # HP Smart
    '9NKSQGP7F2NH' # WhatsApp
)
foreach ($programa in $programasInstalarWindowsStore)
{
    & $winget install --silent --id "$programa" --source msstore
}