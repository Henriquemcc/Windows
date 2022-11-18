Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Add-DirectoryToPath.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinRootPath.ps1")) -Global -Force

function Add-CygwinToPath {

    <#
    .SYNOPSIS
        Adds Cygwin 'bin' directory to system or user environment variable 'Path'
    .DESCRIPTION
        Adds to system or user environment variable 'Path' Cygwin 'bin' directory.
    .EXAMPLE
        Add-CygwinToPath
        Adds Cygwin 'bin' directory to system or user environment variable 'Path'.
    #>

    $cygwinRootPath = Get-CygwinRootPath
    
    Add-DirectoryToPath -DirectoryPath ([System.IO.Path]::Combine($cygwinRootPath, "bin"))
}