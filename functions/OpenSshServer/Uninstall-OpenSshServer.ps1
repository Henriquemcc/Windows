function Uninstall-OpenSshServer
{
    <#
    .SYNOPSIS
        Uninstalls Open SSH Server.
    .DESCRIPTION
        Uninstalls Open SSH Server.
    #>

    # Stopping and removing sshd service
    Stop-Service -Name "sshd" -Force
    Remove-Service -Name "sshd" -Force

    # Removing Firewall rule
    if (Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)
    {
        Remove-NetFirewallRule -Name "OpenSSH-Server-In-TCP"
    }

    # Removing Open SSH Server
    Remove-WindowsCapability -Online -Name "OpenSSH.Server*"
}