Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "DefragSystemPartition.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Repair-SystemFilesWithSfc.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Repair-SystemImageWithDism.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Repair-SystemPartition.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "RepairWindows.psm1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "CleanWindows", "Remove-UselessFilesWithCleanmgr.ps1")) -Global -Force

function DefaultRepair
{
    Repair-SystemImageWithDism

    Repair-SystemFilesWithSfc

    Remove-UselessFilesWithCleanmgr

    DefragSystemPartition

    Repair-SystemPartition
}