﻿Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Util", "Set-ItemPermission.ps1")) -Global -Force

function Set-OpenSshAdministratorAuthorizedKeysPermissions
{
    <#
    .SYNOPSIS
        Changes permission on Open SSH Server's administrators_authorized_keys file.
    .DESCRIPTION
        Changes permission on Open SSH Server's administrators_authorized_keys file.
    #>

    # https://superuser.com/questions/1342411/setting-ssh-keys-on-windows-10-openssh-server

    # Defining access rules
    $accessRule = @(
    [System.Security.AccessControl.FileSystemAccessRule]::new("Administrators", "FullControl", "Allow"),
    [System.Security.AccessControl.FileSystemAccessRule]::new("System", "FullControl", "Allow")
    )

    # Defining path
    $path = [System.IO.Path]::Combine($env:ProgramData, "ssh", "administrators_authorized_keys")

    # Changing file permission
    Set-ItemPermission -Path:$path -AcessRule:$accessRule -IsProtected:$true -PreserveInheritance:$false

    # Restarting Open SSH Server service
    Restart-Service -Name "sshd"
}