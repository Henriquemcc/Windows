# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Instalando Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Obtendo a localização do Winget
$winget = (Get-Command -Name winget).Source
if ($null -eq $winget) {
    $winget = ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))
}

# Atualizando programas
& $winget upgrade --silent --all

# Desinstalando programas
& $winget uninstall --silent --id Microsoft.OneDrive
& $winget uninstall --silent --id 9NBLGGH5R558 # Microsoft To Do
& $winget uninstall --silent --id 9NBLGGH4QGHW # Microsoft Sticky Notes
& $winget uninstall --silent --id 9P1J8S7CCWWT # Microsoft Clipchamp
& $winget uninstall --silent --id 9WZDNCRFHVFW # Microsoft Notícias

# Instalando programas
& $winget install --silent --id Mozilla.Firefox.ESR --source winget
& $winget install --silent --id Google.Chrome --source winget
& $winget install --silent --id Bitwarden.Bitwarden --source winget
& $winget install --silent --id Spotify.Spotify --source winget
& $winget install --silent --id Microsoft.Teams --source winget
& $winget install --silent --id OpenWhisperSystems.Signal --source winget
& $winget install --silent --id 7zip.7zip --source winget
& $winget install --silent --id VideoLAN.VLC --source winget
& $winget install --silent --id EclipseAdoptium.Temurin.21.JDK --source winget
& $winget install --silent --id EclipseAdoptium.Temurin.8.JDK --source winget
& $winget install --silent --id Python.Python.3 --source winget
& $winget install --silent --id Microsoft.VisualStudioCode --source winget
& $winget install --silent --id Git.Git--source winget
& $winget install --silent --id JetBrains.IntelliJIDEA.Community --source winget
& $winget install --silent --id JetBrains.PyCharm.Community --source winget
& $winget install --silent --id Microsoft.WindowsTerminal --source winget
& $winget install --silent --id Microsoft.VisualStudio.2022.Community --source winget
& $winget install --silent --id TheDocumentFoundation.LibreOffice --source winget
& $winget install --silent --id Adobe.Acrobat.Reader.64-bit --source winget
& $winget install --silent --id Discord.Discord --source winget
& $winget install --silent --id GIMP.GIMP --source winget
& $winget install --silent --id Oracle.VirtualBox --source winget
& $winget install --silent --id Giorgiotani.Peazip --source winget
& $winget install --silent --id WireGuard.WireGuard --source winget
& $winget install --silent --id Microsoft.BingWallpaper --source winget
& $winget install --silent --id Discord.Discord --source winget
& $winget install --silent --id Audacity.Audacity --source winget
& $winget install --silent --id gerardog.gsudo --source winget
& $winget install --silent --id Rclone.Rclone --source winget
& $winget install --silent --id GitHub.cli --source winget
& $winget install --silent --id Microsoft.Skype --source winget
& $winget install --silent --id Valve.Steam --source winget
& $winget install --silent --id ElectronicArts.EADesktop --source winget
& $winget install --silent --id EpicGames.EpicGamesLauncher --source winget
& $winget install --silent --id Ubisoft.Connect --source winget
& $winget install --silent --id DominikReichl.KeePass --source winget
& $winget install --silent --id Rufus.Rufus --source winget