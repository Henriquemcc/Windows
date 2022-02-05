<#
.SYNOPSIS
    Runs Ccleaner.
.DESCRIPTION
    Runs Ccleaner.
#>

# Installing Ccleaner if it is not installed
.\Install-Ccleaner.ps1

# Running Ccleaner
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = [System.IO.Path]::Combine($env:ProgramFiles, "CCleaner", "CCleaner64.exe")
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()