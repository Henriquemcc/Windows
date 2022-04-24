function Start-KasperskyVirusRemovalTool
{
    <#
    .SYNOPSIS
        Runs Kaspersky Virus Removal Tool.
    .DESCRIPTION
        Retrieves and execute Kaspersky Virus Removal Tool.
    #>

    # Downloading Kaspersky Virus Removal Tool
    $url = "https://devbuilds.s.kaspersky-labs.com/devbuilds/KVRT/latest/full/KVRT.exe"
    $downloadFile = [System.IO.Path]::Combine($env:TEMP, "KVRT.exe")
    Invoke-WebRequest -Uri $url -OutFile $downloadFile

    # Running Kaspersky Virus Removal Tool
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFile
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}