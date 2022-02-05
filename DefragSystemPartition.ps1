<#
.SYNOPSIS
    Defrags system partition.
.DESCRIPTION
    Defrags system partition.
#>

# defrag C: /Optimize /PrintProgress /Verbose

$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "defrag").Source)
        $process.StartInfo.Arguments = "$($env:SystemDrive) /Optimize /PrintProgress /Verbose"
        $process.StartInfo.UseShellExecute = $true

        # Imprimindo comando
        Write-Host -Object "$($process.StartInfo.FileName) $($process.StartInfo.Arguments)"

        # Executando o comando
        $process.Start()
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::RealTime
        $process.WaitForExit()
        $_error = $false
    }
    catch {
        Write-Error $_
        $_error = $true
    }    
}
while ($_error)