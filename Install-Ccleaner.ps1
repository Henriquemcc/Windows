<#
.SYNOPSIS
    Installs Ccleaner.
.DESCRIPTION
    Installs Ccleaner.
#>

Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "Chocolatey", "Chocolatey.psm1"))

# Installing Chocolatey if it is not installed
Install-Chocolatey

# Installing Ccleaner
choco install ccleaner --yes