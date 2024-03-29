﻿function Repair-SystemPartition
{
    <#
    .SYNOPSIS
        Repairs system partition.
    .DESCRIPTION
        Repairs system partition.
    #>

    # chkdsk C: /F /V /R
    try
    {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "chkdsk").Source)
        $process.StartInfo.Arguments = "$( $env:SystemDrive ) /F /V /R"
        $process.StartInfo.UseShellExecute = $true

        # Imprimindo comando
        Write-Host -Object "$( $process.StartInfo.FileName ) $( $process.StartInfo.Arguments )"

        # Executando o comando
        $process.Start()
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::RealTime
        $process.WaitForExit()
    }
    catch
    {
        Write-Error $_
    }

}