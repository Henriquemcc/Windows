<#
.SYNOPSIS
    Installs Ccleaner.
.DESCRIPTION
    Installs Ccleaner.
#>

# Installing Chocolatey if it is not installed
.\Install-Chocolatey.ps1

# Installing Ccleaner
choco install ccleaner --yes