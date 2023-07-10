Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Chocolatey", "Chocolatey.psm1"))
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Cygwin", "Cygwin.psm1"))

# Configurando registro
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-PasswordOnWindowsUAC.ps1"))
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Registry", "Enable-RetpolineSpectreMitigation.ps1"))

# Alterando o protocolo de seguranca
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Instalando o modulo package management
Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery

# Instalando gerenciadores de pacotes
## Instalando o gerenciador de pacotes chocolatey
Install-Chocolatey
## Instalando o Winget
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Winget.ps1"))


# Instalando programas de produtividade
## Instalando o Firefox
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-FirefoxEsr.ps1"))
## Instalando o KeePassXc
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-KeePassXc.ps1"))
## Instalando o LibreOffice
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-LibreOffice.ps1"))

# Instalando ferramentas de desenvolvimento
## Instalando o Git
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Git.ps1"))
## Instalando o Visual Studio Code
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-VisualStudioCode.ps1"))
## Instalando o IntelliJ
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-IntellijIdeaCommunity.ps1"))
## Instalando Python
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-Python.ps1"))

# Adicionando Cygwin ao path
Add-CygwinToPath

# Atualizando o menu de ajuda do PowerShell
Update-Help -Force -ErrorAction Ignore