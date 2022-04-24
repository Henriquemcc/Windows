function Repair-SystemImageWithDism
{
    <#
    .SYNOPSIS
        Repairs Windows system image with DISM.
    .DESCRIPTION
        Repairs Windows system image with DISM.
    #>

    # dism /Online /Cleanup-image /Scanhealth
    try
    {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/Online /Cleanup-image /Scanhealth"
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

    # dism /Online /Cleanup-image /Restorehealth
    try
    {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/Online /Cleanup-image /Restorehealth"
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

    #dism /online /cleanup-image /startcomponentcleanup
    try
    {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/online /cleanup-image /startcomponentcleanup"
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