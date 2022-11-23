Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Chocolatey", "Install-ChocolateyPackage.ps1")) -Global -Force

function Install-Ccleaner
{
    <#
    .SYNOPSIS
        Installs Ccleaner.
    .DESCRIPTION
        Installs Ccleaner.
    #>

    # Installing Ccleaner
    Install-ChocolateyPackage -Package "ccleaner" -ConfirmAllPrompts
}