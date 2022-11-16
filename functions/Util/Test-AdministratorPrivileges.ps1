function Test-AdministratorPrivileges {

    <#
    .SYNOPSIS
        Check if PowerShell is running as administrator.
    .DESCRIPTION
        Check if PowerShell is running with administrator privileges.
    .OUTPUTS
        Boolean value indicating whether it is running with administrator privileges.
    .EXAMPLE
        Test-Administrator
        Will return true or false value depending on whether PowerShell has administrator privileges or not.
    #>
    
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}