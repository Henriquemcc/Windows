Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

# Download Variables
$baseUrl = "https://az764295.vo.msecnd.net/stable/97dec172d3256f8ca4bfb2143f3f76b503ca0534/"
$version = "1.74.3"
$url = if (Test-AdministratorPrivileges) {

    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "$($baseUrl)VSCodeSetup-x64-$($version).exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "$($baseUrl)VSCodeSetup-ia32-$($version).exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        "$($baseUrl)VSCodeSetup-arm64-$($version).exe"
    }
    else {
        throw "Invalid Architecture"
    }
}
else {
    
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "$($baseUrl)VSCodeUserSetup-x64-$($version).exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "$($baseUrl)VSCodeUserSetup-ia32-$($version).exe"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "arm64") {
        "$($baseUrl)VSCodeUserSetup-arm64-$($version).exe"
    }
    else {
        throw "Invalid Architecture"
    }
}

$downloadFileName = [System.IO.Path]::GetFileName($url)
$downloadDirectoryPath = $env:TMP
$downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

# Downloading
Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

# Installation variables
$silentInstallArgs = @("/verysilent", "/suppressmsgboxes")

# Installing Visual Studio Code
$process = [System.Diagnostics.Process]::new()
$process.StartInfo.FileName = $downloadFilePath
$process.StartInfo.Arguments = $silentInstallArgs -join " "
$process.StartInfo.UseShellExecute = $true
$process.Start()
$process.WaitForExit()