# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Enable-RetpolineSpectreMitigation.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Restore-ClassicWindowsExplorerContextMenu.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Enable-SshAgent.ps1"))

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
    & $winget uninstall --silent "$programa"
}

# Instalando programas
$programasInstalarWinget = @('Mozilla.Firefox.ESR', 'Google.Chrome', 'Bitwarden.Bitwarden', 'SumatraPDF.SumatraPDF', 'OpenWhisperSystems.Signal',
'7zip.7zip', 'VideoLAN.VLC', 'EclipseAdoptium.Temurin.21.JDK', 'EclipseAdoptium.Temurin.8.JDK', 'Python.Python.3.12', 'Microsoft.VisualStudioCode',
'Git.Git', 'JetBrains.IntelliJIDEA.Community', 'JetBrains.PyCharm.Community', 'Microsoft.WindowsTerminal', 'Microsoft.VisualStudio.2022.Community',
'TheDocumentFoundation.LibreOffice', 'Adobe.Acrobat.Reader.64-bit', 'Discord.Discord', 'GIMP.GIMP', 'Oracle.VirtualBox', 'Giorgiotani.Peazip',
'WireGuard.WireGuard', 'Microsoft.BingWallpaper', 'Audacity.Audacity', 'gerardog.gsudo', 'Rclone.Rclone', 'GitHub.cli', 'Valve.Steam',
'ElectronicArts.EADesktop', 'EpicGames.EpicGamesLauncher', 'Ubisoft.Connect', 'DominikReichl.KeePass', 'Rufus.Rufus', 'JGraph.Draw',
'Oracle.MySQLWorkbench', 'Nvidia.CUDA', 'Nvidia.GeForceExperience', 'PuTTY.PuTTY', 'HARMAN.AdobeAIR', 'JetBrains.CLion', 'Docker.DockerDesktop',
'DominikReichl.KeePass ', 'Insecure.Nmap', 'OBSProject.OBSStudio', 'qBittorrent.qBittorrent', 'Python.Launcher', 'Cisco.Webex', 'Gyan.FFmpeg',
'Postman.Postman', 'Stremio.Stremio', 'JetBrains.Toolbox', 'KDE.Kdenlive', 'yt-dlp.yt-dlp', 'Debian.Debian', 'Microsoft.PowerToys')
foreach ($programa in $programasInstalarWinget)
{
    & $winget install --silent "$programa" --source winget
}

# Instalando programas da Microsoft Store
# Microsoft Teams, Spotify, HP Smart, WhatsApp
& $winget install --silent 'XP8BT8DW290MPQ'  '9NCBCSZSJRSB' '9WZDNCRFHWLH' '9NKSQGP7F2NH' --source msstore

# Configurando o Git
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "ConfigurarGit.ps1"))
