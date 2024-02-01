# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Instalando Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalando Winget
& ([System.IO.Path]::Combine($env:ProgramData, "chocolatey", "bin", "choco.exe")) install winget -y

# Instalando programas
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Google.Chrome --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id VideoLAN.VLC --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id 7zip.7zip --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Microsoft.Teams --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Bitwarden.Bitwarden --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Google.GoogleDrive --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Oracle.JavaRuntimeEnvironment --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Mozilla.Firefox.ESR --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id TheDocumentFoundation.LibreOffice.LTS --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id DominikReichl.KeePass --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Microsoft.WindowsTerminal --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Microsoft.VisualStudioCode --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Git.Git -e --source winget --custom "/WindowsTerminalProfile" --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Python.Python.3 --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Oracle.JDK.21 --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id EpicGames.EpicGamesLauncher --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Ubisoft.Connect --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id WireGuard.WireGuard --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id dotPDNLLC.paintdotnet --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Adobe.Acrobat.Reader.64-bit --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Valve.Steam --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id ElectronicArts.EADesktop --source winget
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Rufus.Rufus --source winget --scope user
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  install --silent --id Microsoft.BingWallpaper --source winget --scope user

# Atualizando programas
& ([System.IO.Path]::Combine($env:LOCALAPPDATA, "Microsoft", "WindowsApps", "winget.exe"))  upgrade --silent --all