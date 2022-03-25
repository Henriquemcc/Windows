param(
    [Parameter(Mandatory = $false)][System.Boolean]$InfiniteLooping = $false
)

do {
    $processes = [System.Diagnostics.Process]::GetProcesses()

    foreach ($process in $processes) {
        if ($false -eq $process.Responding) {
            try {
                $process.Kill()
            }
            catch {
                Write-Error -Message $_
            }
            
        }
    }

} while ($InfiniteLooping)