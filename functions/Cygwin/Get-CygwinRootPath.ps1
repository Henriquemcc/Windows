Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Test-AdministratorPrivileges.ps1")) -Global -Force

function Get-CygwinRootPath
{
    # Base directory where cygwin will be installed
    $installationBaseDirectory = if(Test-AdministratorPrivileges){
        if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {$env:ProgramFiles }
        elseif($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "x86") {${env:ProgramFiles(x86)}}
    } else {[System.IO.Path]::Combine($env:APPDATA)}

    # Installation directory name
    $directoryName = "cygwin"
    if ($env:PROCESSOR_ARCHITECTURE.ToLower() -eq "amd64") {
        $directoryName += "64"
    }

    # Defining complete path
    $path = [System.IO.Path]::Combine($installationBaseDirectory, $directoryName)

    # Creating installation directories
    New-Item -Path:$path -ItemType Directory -ErrorAction SilentlyContinue

    return $path
}