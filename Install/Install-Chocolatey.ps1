Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

if (-not (Get-Command -Name "choco" -ErrorAction SilentlyContinue)) {
    # Set directory for installation - Chocolatey does not lock
    # down the directory if not the default
    $InstallDir = if (Test-AdministratorPrivileges) {
        [System.IO.Path]::Combine($env:PROGRAMDATA, "chocolatey")
    }
    else {
        [System.IO.Path]::Combine($env:LOCALAPPDATA, "Programs", "Chocolatey")
    }

    # Creating installation directory
    New-Item -Path:$InstallDir -ItemType Directory -Force -ErrorAction SilentlyContinue
    

    $env:ChocolateyInstall = $InstallDir

    # If your PowerShell Execution policy is restrictive, you may
    # not be able to get around that. Try setting your session to
    # Bypass.
    Set-ExecutionPolicy Bypass -Scope Process -Force;

    # All install options - offline, proxy, etc at
    # https://chocolatey.org/install
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))   
}