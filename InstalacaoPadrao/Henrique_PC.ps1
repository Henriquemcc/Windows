﻿# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Instalando Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalando Winget
& ([System.IO.Path]::Combine($env:ProgramData, "chocolatey", "bin", "choco.exe")) install winget -y

# Instalando programas
winget install --silent --id Google.Chrome --source winget
winget install --silent --id VideoLAN.VLC --source winget
winget install --silent --id 7zip.7zip --source winget
winget install --silent --id Microsoft.Teams --source winget --scope user
winget install --silent --id Bitwarden.Bitwarden --source winget --scope user
winget install --silent --id Oracle.JavaRuntimeEnvironment --source winget
winget install --silent --id Mozilla.Firefox.ESR --source winget --scope user
winget install --silent --id TheDocumentFoundation.LibreOffice.LTS --source winget
winget install --silent --id DominikReichl.KeePass --source winget --scope user
winget install --silent --id Microsoft.WindowsTerminal --source winget
winget install --silent --id Microsoft.VisualStudioCode --source winget --scope user
winget install --silent --id Git.Git -e --source winget --custom "/WindowsTerminalProfile" --scope user
winget install --silent --id Python.Python.3 --source winget --scope user
winget install --silent --id Oracle.JDK.21 --source winget
winget install --silent --id EpicGames.EpicGamesLauncher --source winget
winget install --silent --id Ubisoft.Connect --source winget
winget install --silent --id WireGuard.WireGuard --source winget
winget install --silent --id dotPDNLLC.paintdotnet --source winget --scope user
winget install --silent --id Adobe.Acrobat.Reader.64-bit --source winget
winget install --silent --id Valve.Steam --source winget
winget install --silent --id ElectronicArts.EADesktop --source winget
winget install --silent --id Rufus.Rufus --source winget --scope user

# Atualizando programas
winget upgrade --silent --all