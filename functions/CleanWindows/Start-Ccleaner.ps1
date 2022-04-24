Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Install-Ccleaner.ps1"))

function Start-Ccleaner
{
    <#
    .SYNOPSIS
        Runs Ccleaner.
    .DESCRIPTION
        Runs Ccleaner.
    #>

    # Installing Ccleaner if it is not installed
    Install-Ccleaner

    # Running Ccleaner
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = [System.IO.Path]::Combine($env:ProgramFiles, "CCleaner", "CCleaner64.exe")
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}