# Installing Chocolatey package manager
.\Install-Chocolatey.ps1

# Installing Chocolatey packages
choco install malwarebytes firefoxesr 7zip vlc vscode gsudo audacity gimp ccleaner cdburnerxp filezilla googlechrome gh keepass libreoffice-still nomacs paint.net rufus steam avidemux intellijidea-community discord --yes

# Installing Git
choco install git --params "/WindowsTerminalProfile" --yes

# Installing VirtualBox
choco install virtualbox --params "/ExtensionPack" --yes

# Installing Cygwin packages
choco install wget curl nano vim coreutils tar unzip zip unxz xz bash-completion --source cygwin --yes

# Adding Cygwin to path
.\Add-CygwinToPath.ps1

# Setting windows registry keys
.\Set-RegistryKeys.ps1

# Updating PowerShell help
Update-Help -Force -ErrorAction Ignore