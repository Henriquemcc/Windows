﻿Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinInstallerUrl.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinMirror.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinRootPath.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Add-CygwinToPath.ps1")) -Global -Force
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Test-AdministratorPrivileges.ps1")) -Global -Force

function Update-CygwinPackage
{

    # Download Variables
    $url = Get-CygwinInstallerUrl
    $downloadFileName = [System.IO.Path]::GetFileName($url)
    $downloadDirectoryPath = $env:TMP
    $downloadFilePath = [System.IO.Path]::Combine($downloadDirectoryPath, $downloadFileName)

    # Downloading
    Invoke-WebRequest -Uri:$url -OutFile:$downloadFilePath

    # Installation variables
    $silentInstallArgs = [System.Collections.ArrayList]::new()

    # Architecture
    $architeture = if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {"x86_64"} elseif ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {"x86"}
    $silentInstallArgs.Add("--arch $architeture")

    # Quiet Mode
    $silentInstallArgs.Add("--quiet-mode")

    # No-Admin
    if (-not (Test-AdministratorPrivileges))
    {
        $silentInstallArgs.Add("--no-admin")
    }

    # Mirror
    $mirror = Get-CygwinMirror
    $silentInstallArgs.Add("--site $mirror")

    # Root Path
    $rootPath = Get-CygwinRootPath
    $silentInstallArgs.Add("--root $rootPath")

    # Local Package Dir
    $localPackageDir = $env:TEMP
    $silentInstallArgs.Add("--local-package-dir $localPackageDir")

    # Force Current
    $silentInstallArgs.Add("--force-current")

    # Installing Package
    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo.FileName = $downloadFilePath
    $process.StartInfo.Arguments = $silentInstallArgs -join " "
    $process.StartInfo.UseShellExecute = $true
    $process.Start()
    $process.WaitForExit()

    # Adding Cygwin to path
    Add-CygwinToPath
}