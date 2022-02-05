<#
.SYNOPSIS
    Removes useless files using cleanmgr.
.DESCRIPTION
    Removes useless files using cleanmgr.
#>

# cleanmgr /d C: /verylowdisk

$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "cleanmgr").Source)
        $process.StartInfo.Arguments = "/d $($env:SystemDrive) /verylowdisk"
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