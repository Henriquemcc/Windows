Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Test-Expression.ps1")) -Global -Force

function Install-Chocolatey
{
    <#
    .SYNOPSIS
        Installs Chocolatey package manager
    .DESCRIPTION
        Installs Chocolatey package manager
    #>

    if (-not(Test-Expression -Command "choco"))
    {

        # Installing Chocolatey
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
}