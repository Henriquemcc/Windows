Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Install-Cygwin.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "..", "Chocolatey", "Install-Chocolatey.ps1"))

function Add-CygwinToPath
{
    # Installing Cygwin
    Install-Cygwin

    # Installing Chocolatey
    Install-Chocolatey

    # Importing Chocolatey Installer Module
    Import-Module -Name "$($env:ChocolateyInstall)\helpers\chocolateyInstaller.psm1"

    # Adding Cygwin bin folder to system path
    Install-ChocolateyPath -PathToInstall "$($env:SystemDrive)\tools\cygwin\bin"
}

