function DefragSystemPartition
{
    <#
    .SYNOPSIS
        Defrags system partition.
    .DESCRIPTION
        Defrags system partition.
    #>

    # defrag C: /Optimize /PrintProgress /Verbose
    try
    {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "defrag").Source)
        $process.StartInfo.Arguments = "$( $env:SystemDrive ) /Optimize /PrintProgress /Verbose"
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