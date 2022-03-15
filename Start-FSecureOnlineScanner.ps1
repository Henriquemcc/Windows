<#
.SYNOPSIS
    Runs F-Secure Online Scanner
.DESCRIPTION
    Retrieves and executes F-Secure Online Scanner
#>

# Downloading ESET Online Scanner
$url = "https://download.sp.f-secure.com/tools/F-SecureOnlineScanner.exe"
$downloadFile = [System.IO.Path]::Combine($env:TEMP, "F-SecureOnlineScanner.exe")
Invoke-WebRequest -Uri $url -OutFile $downloadFile

# Running ESET Online Scanner
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFile
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()