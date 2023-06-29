Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Chocolatey", "Chocolatey.psm1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Cygwin", "Cygwin.psm1"))

# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Alterando o protocolo de seguranca
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Instalando o modulo package management
Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery

# Instalando o gerenciador de pacotes chocolatey
Install-Chocolatey

# Instalando pacotes chocolatey
choco install googlechrome firefox 7zip vlc vscode gsudo audacity gimp ccleaner cdburnerxp filezilla gh keepassxc libreoffice-still nomacs paint.net --yes
choco install virtualbox --params "/ExtensionPack" --yes
choco install wget curl nano vim coreutils tar unzip zip unxz xz bash-completion --source cygwin --yes

# Instalando o Winget
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Winget.ps1"))

# Instalando Python
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Python.ps1"))

# Instalando o KeePass
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-KeePass.ps1"))

# Instalando o Git
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Git.ps1"))

# Adicionando Cygwin ao path
Add-CygwinToPath

# Alterando chaves do registro
.\Set-RegistryKeys.ps1

# Atualizando o menu de ajuda do PowerShell
Update-Help -Force -ErrorAction Ignore