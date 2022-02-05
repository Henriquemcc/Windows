<#
.SYNOPSIS
    Installs Chocolatey package manager
.DESCRIPTION
    Installs Chocolatey package manager
#>

if (-not (.\Test-Expression.ps1 -Command "choco")) {

    # Installing Chocolatey
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Setting up Chocolatey
    choco feature enable -name=exitOnRebootDetected
}