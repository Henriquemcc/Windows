<#
.SYNOPSIS
    Repairs Windows system image with DISM.
.DESCRIPTION
    Repairs Windows system image with DISM.
#>

# dism /Online /Cleanup-image /Scanhealth

$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/Online /Cleanup-image /Scanhealth"
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
    

# dism /Online /Cleanup-image /Restorehealth

$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/Online /Cleanup-image /Restorehealth"
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


#dism /online /cleanup-image /startcomponentcleanup
$_error = $false
do {
    try {
        $process = [System.Diagnostics.Process]::new()
        $process.StartInfo.FileName = ((Get-Command -Name "dism").Source)
        $process.StartInfo.Arguments = "/online /cleanup-image /startcomponentcleanup"
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