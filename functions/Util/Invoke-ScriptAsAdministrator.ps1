Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Test-AdministratorPrivileges.ps1")) -Global -Force

function Invoke-ScriptAsAdministrator {

    <#
    .SYNOPSIS
        This function elevates the current script to run as administrator.
    .DESCRIPTION
        This function elevates the current script to run as administrator.
    .EXAMPLE
        Invoke-ScriptAsAdministrator -WorkingDirectory $(Get-Location) -ScriptPath $MyInvocation.MyCommand.Definition -Exit
        This example elevates the current script to run as administrator, set the working directory the the current working directory and exits the current script after that.
    #>

    param (
        # Working directory to be set
        [Parameter(Mandatory = $false)][System.String]$WorkingDirectory,

        # The path of the powershell script to execute
        [Parameter(Mandatory = $false)][System.String]$ScriptPath,

        # The commands to execute
        [Parameter(Mandatory = $false)][System.Management.Automation.ScriptBlock]$Commands,

        # Whether to exit the current script after elevating privileges
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$Exit
    )

    # Getting the powershell executable path
    $powershell = ([System.IO.Path]::Combine("$PSHOME", "powershell.exe"))
    if ($null -eq $powershell) {
        $powershell = (Get-Command -Name powershell).Source
    }
    if ($null -eq $powershell) {
        $powershell = ([System.IO.Path]::Combine("C", "Windows", "System32", "WindowsPowerShell", "v1.0", "powershell.exe"))
    }

    # Exiting if neither script path nor commands to execute were provided
    if (($null -eq $ScriptPath -or $ScriptPath.Length -eq 0) -and ($null -eq $Commands -or $Commands.Length -eq 0)) {
        Write-Host "No script path or commands to execute"
        return
    }

    # Exiting if both script path and commands to execute were provided
    if (($null -ne $ScriptPath -and $ScriptPath.Length -gt 0) -and ($null -ne $Commands -and $Commands.ToString().Length -gt 0)) {
        Write-Host "Both script path and commands to execute were provided"
        return
    }

    # Elevating privileges
    if (-Not (Test-AdministratorPrivileges)) {
        Write-Host "This script is not running as administrator"
        Write-Host "Elevating privileges..."
        
        # Building the command string
        $stringBuilder = [System.Text.StringBuilder]::new()
        [void]$stringBuilder.Append("-Command `"& { ")
        
        # Adding the working directory
        if ($null -ne $WorkingDirectory -and $WorkingDirectory.Length -gt 0) {
            [void]$stringBuilder.Append("Set-Location -Path $WorkingDirectory; ")
        }

        # Adding the script path to execute
        if ($null -ne $ScriptPath -and $ScriptPath.Length -gt 0) {
            [void]$stringBuilder.Append("& $ScriptPath")
        }

        # Adding the commands to execute
        if ($null -ne $Commands -and $Commands.ToString().Length -gt 0) {
            [void]$stringBuilder.Append("$($Commands.ToString())")
        }

        # Finishing the command string
        [void]$stringBuilder.Append(" }`"")
        $command = $stringBuilder.ToString()
    
        # Starting the new process
        Start-Process -FilePath $powershell -Verb RunAs -ArgumentList:$command
        
        # Exiting
        if ($Exit) {
            exit $LastExitCode
        }

        return $LastExitCode
    }
}