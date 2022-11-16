Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinInstallerUrl.ps1")) -Global
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinMirror.ps1")) -Global
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Get-CygwinRootPath.ps1")) -Global
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Add-CygwinToPath.ps1")) -Global
Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Test-AdministratorPrivileges.ps1")) -Global

function Uninstall-CygwinPackage
{
    param(
        # Packages to be removed.
        [Parameter(Mandatory = $false, Position = 0)]$Packages,

        # Categories to be removed.
        [Parameter(Mandatory = $false, Position = 1)]$Categories
    )
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

    # Package
    if ($Packages)
    {
        if ($Packages -isnot [System.String])
        {
            $Packages = $Packages -join " "
        }
        $silentInstallArgs.Add("--remove-packages $Packages")
    }

    # Categories
    if ($Categories)
    {
        if ($Categories -isnot [System.String])
        {
            $Categories = $Categories -join " "
        }
        $silentInstallArgs.Add("--remove-categories $Categories")
    }

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