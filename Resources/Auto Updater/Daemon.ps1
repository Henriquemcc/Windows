$updateSystemSafelyScript = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Update-SystemSafely.ps1")
$logsFile = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "UpdateService.log")
while ($true) {
    try {
        & $updateSystemSafelyScript | Out-File -Append $logsFile
    }
    catch {
        $_ | Out-File -Append $logsFile
    }
    Start-Sleep -Seconds (60*60*24)
}