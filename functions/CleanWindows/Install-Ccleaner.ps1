Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "..", "Chocolatey", "Chocolatey.psm1"))

function Install-Ccleaner
{
    <#
    .SYNOPSIS
        Installs Ccleaner.
    .DESCRIPTION
        Installs Ccleaner.
    #>

    # Installing Chocolatey if it is not installed
    Install-Chocolatey

    # Installing Ccleaner
    choco install ccleaner --yes
}