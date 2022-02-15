<#
.SYNOPSIS
    Runs ESET Online Scanner
.DESCRIPTION
    Retrieves and executes ESET Online Scanner
#>

# Downloading ESET Online Scanner
$url = "https://download.eset.com/com/eset/tools/online_scanner/latest/esetonlinescanner.exe"
$downloadFile = [System.IO.Path]::Combine($env:TEMP, "esetonlinescanner.exe")
Invoke-WebRequest -Uri $url -OutFile $downloadFile

# Running ESET Online Scanner
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFile
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()