param(
    [Parameter(Mandatory = $true)] [System.String[]] $Path,
    [Parameter(Mandatory = $true)] [System.String] $Name,
    [Parameter(Mandatory = $false)] [System.Object] $Value = $null,
    [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter] $Reverse,
    [Parameter(Mandatory = $false)] [System.String] $BackupFilePath = ""
)

<#
.SYNOPSIS
    Set a key in Windows registry and backups the old value.
.DESCRIPTION
    Set a key in Windows registry and backups the old value.
.EXAMPLE
    PS C:\> .\Set-RegistryKey.ps1 -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 1
    This example changes "ConsentPromptBehaviorAdmin" in "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" to value 1.
.EXAMPLE
    PS C:\> .\Set-RegistryKey.ps1 -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Reverse
    This example changes "ConsentPromptBehaviorAdmin" in "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" to the backuped value.
.PARAMETER Path
    Registry path.
.PARAMETER Name
    Registry key name.
.PARAMETER Value
    New value for the registry key.
.PARAMETER Reverse
    Wether is to restore the old value.
.PARAMETER BackupFilePath
    Path of the backup file.
#>

if ($null -eq $Value -and $Reverse -eq $false) {
    throw "Invalid option: Parameter `$Value can not be null if `$Reverse is disable"
}

# Setting backup file path variable
if ($BackupFilePath.Length -le 0) {

    $BackupFilePath = [System.IO.Path]::Combine($PSScriptRoot, "backup")

    foreach($p in $Path) {
        $BackupFilePath = [System.IO.Path]::Combine($BackupFilePath, $p.Replace(":", ""))
    }

    $BackupFilePath = [System.IO.Path]::Combine($BackupFilePath, $Name)
}

# Reversing registry value
if ($Reverse) {

    if (Test-Path -Path $BackupFilePath) {

        # Restoring value from backup
        $oldValue = Get-Content -Path $BackupFilePath

        # Setting value from backup
        Set-ItemProperty -Path $Path -Name $Name -Value $oldValue -Force

        # Deleting backup file
        Remove-Item -Path $BackupFilePath
    }
    else {
        throw "Backup file not found"
    }

}

# Setting new registry value
else {

    # Getting registry value
    $currentValue = Get-ItemPropertyValue -Path $Path -Name $Name

    # Checking if current value is different from the new value
    if ($currentValue -ne $Value) {

        # Ensuring the backup file does not exist
        if (Test-Path -Path $BackupFilePath -PathType Leaf) {
            throw "Backup file already exists"
        }

        # Creating backup file's directory
        New-Item -Path (Split-Path -Path $BackupFilePath -Parent) -ItemType Directory | Out-Null

        # Backing up current registry value
        Out-File -Path $BackupFilePath -InputObject $currentValue

        # Changing registry
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force

    }
}