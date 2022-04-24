Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "DefragSystemPartition.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Repair-SystemFilesWithSfc.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Repair-SystemImageWithDism.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "Repair-SystemPartition.ps1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "RepairWindows.psm1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "..", "CleanWindows", "Remove-UselessFilesWithCleanmgr.ps1"))

function DefaultRepair
{
    Repair-SystemImageWithDism

    Repair-SystemFilesWithSfc

    Remove-UselessFilesWithCleanmgr

    DefragSystemPartition

    Repair-SystemPartition
}