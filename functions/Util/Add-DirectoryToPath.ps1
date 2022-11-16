Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Test-AdministratorPrivileges.ps1")) -Global

function Add-DirectoryToPath {
    param(
        [Parameter(Mandatory = $true, Position = 0)][System.String]$DirectoryPath
    )

    <#
    .SYNOPSIS
        Adds a directory to system or user path
    .DESCRIPTION
        Adds a directory path string to the system or user environment variable called 'Path'.
    .PARAMETER DirectoryPath
        String with the complete path of the directory to be added to 'Path' variable.
    .EXAMPLE
        Add-DirectoryToPath -DirectoryPath "C:\bin"
        Directory C:\bin will be added to user or system 'Path' variable
    #>

    if ($DirectoryPath.Contains(";"))
    {
        throw "DirectoryPath parameter can not contain ';'"
    }

    # Getting target according to whether it has administrator privileges or not
    $target = if (Test-AdministratorPrivileges) {
        [System.EnvironmentVariableTarget]::Machine
    }
    else {
        [System.EnvironmentVariableTarget]::User
    }

    # Getting path environment variable
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", $target)

    if (-not ($envPath.Contains($DirectoryPath))) {

        # Adding new path to string
        if ($envPath.Length -gt 0 -and (-not $envPath.EndsWith(";"))) {
            $envPath += ";"
        }
        $envPath += $DirectoryPath

        # Setting path environment variable
        [System.Environment]::SetEnvironmentVariable("Path", $envPath, $target)
    }
}