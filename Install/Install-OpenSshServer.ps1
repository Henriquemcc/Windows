﻿Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Util", "Test-AdministratorPrivileges.ps1"))

<#
.SYNOPSIS
    Installs Open SSH Server.
.DESCRIPTION
    Installs Open SSH Server, enables Open SSH Server system service, and enables Open SSH Server on Windows Firewall.
#>

# https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse

if (-not (Test-AdministratorPrivileges)) {
    throw "Administrator privileges are required"
}

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}
else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}