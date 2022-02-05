# Alterando o protocolo de seguranca
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Reparando o Windows
.\Repair-Windows.ps1

# Instalando o modulo package management
Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery

# Instalando o gerenciador de pacotes chocolatey
.\Install-Chocolatey.ps1

# Instalando pacotes chocolatey
choco install googlechrome firefox 7zip vlc vscode gsudo audacity gimp ccleaner cdburnerxp filezilla gh keepassxc libreoffice-still nomacs paint.net --yes
choco install git --params "/WindowsTerminalProfile" --yes
choco install virtualbox --params "/ExtensionPack" --yes
choco install wget curl nano vim coreutils tar unzip zip unxz xz bash-completion --source cygwin --yes

# Adicionando Cygwin ao path
.\Add-CygwinToPath.ps1

# Alterando chaves do registro
.\Set-RegistryKeys.ps1

# Atualizando o menu de ajuda do PowerShell
Update-Help -Force -ErrorAction Ignore