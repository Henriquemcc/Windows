Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "..", "Chocolatey", "Install-ChocolateyPackage.ps1"))

function Install-Cygwin
{
    Install-ChocolateyPackage -Package "Cygwin" -Yes
}