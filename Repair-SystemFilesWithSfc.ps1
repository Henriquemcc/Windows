<#
.SYNOPSIS
    Repairs Windows system files with SFC.
.DESCRIPTION
    Repairs Windows system files with SFC.
#>

# sfc /scannow

$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "sfc").Source)
        $process.StartInfo.Arguments = "/scannow"
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