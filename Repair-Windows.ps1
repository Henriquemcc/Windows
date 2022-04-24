Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "RepairWindows", "RepairWindows.psm1"))

Repair-SystemImageWithDism

Repair-SystemFilesWithSfc

./Remove-UselessFilesWithCleanmgr.ps1

DefragSystemPartition

Repair-SystemPartition