﻿Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

if (Test-AdministratorPrivileges) {

    # Download Variables
    $version = "7.5.4"
    $url = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        "https://download.documentfoundation.org/libreoffice/stable/$($version)/win/x86_64/LibreOffice_$($version)_Win_x86-64.msi"
    }
    elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {
        "https://download.documentfoundation.org/libreoffice/stable/$($version)/win/x86/LibreOffice_$($version)_Win_x86.msi"
    }
    else {
        throw "Invalid Architecture"
    }
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = @("/i", "`"$downloadFilePath`"", "/qn", "/norestart")

    # Installing LibreOffice
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = [System.IO.Path]::Combine($env:windir, "System32", "msiexec.exe")
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}

else {

    # Download Variables
    $version = "7.5.4"
    $url = "https://download.documentfoundation.org/libreoffice/portable/$($version)/LibreOfficePortable_$($version)_MultilingualAll.paf.exe"
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)
    Write-Host $downloadFilePath

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installing LibreOffice
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()
}