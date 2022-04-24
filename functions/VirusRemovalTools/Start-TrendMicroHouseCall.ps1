function Start-TrendMicroHouseCall
{
    <#
    .SYNOPSIS
        Runs Trend Micro HouseCall.
    .DESCRIPTION
        Retrieves and executes Trend Micro HouseCall.
    #>

    $url = ""
    $downloadFile = ""

    # Setting url and download path
    if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64")
    {
        $url = "https://go.trendmicro.com/housecall8/r2/HousecallLauncher64.exe"
        $downloadFile = [System.IO.Path]::Combine($env:TEMP, "HousecallLauncher64.exe")
    }
    elseif ($env:PROCESSOR_ARCHITECTURE -eq "x86")
    {
        $url = "https://go.trendmicro.com/housecall8/r2/HousecallLauncher.exe"
        $downloadFile = [System.IO.Path]::Combine($env:TEMP, "HousecallLauncher.exe")
    }

    # Downloading Trend Micro HouseCall
    Invoke-WebRequest -Uri $url -OutFile $downloadFile

    # Running Trend Micro HouseCall
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFile
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}