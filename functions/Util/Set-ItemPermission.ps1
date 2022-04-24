function Set-ItemPermission
{
    <#
    .SYNOPSIS
        Set permission of a file or directory.
    .DESCRIPTION
        Set permission of a file or directory.
    .PARAMETER Path
        File or directory path.
    .PARAMETER AccessRule
        List of access rules to add.
    .PARAMETER IsProtected
        true to protect the access rules associated with this File/Directory object from inheritance; false to allow inheritance.
    .PARAMETER PreserveInheritance
        true to preserve inherited access rules; false to remove inherited access rules. This parameter is ignored if isProtected is false.
    #>

    param(
        [Parameter(Mandatory = $true)][System.String]$Path,
        [Parameter(Mandatory = $false)][System.Security.AccessControl.FileSystemAccessRule[]]$AcessRule,
        [Parameter(Mandatory = $false)][System.Boolean]$IsProtected = $false,
        [Parameter(Mandatory = $false)][System.Boolean]$PreserveInheritance = $true
    )

    # Getting file/folder security descriptor
    $itemSecurityDescriptor = Get-Acl -Path $Path

    # Setting Access Rule protection
    $itemSecurityDescriptor.SetAccessRuleProtection($IsProtected, $PreserveInheritance)

    # Adding each access rule
    foreach ($rule in $AcessRule)
    {
        $itemSecurityDescriptor.SetAccessRule($rule)
    }

    # Applying security descriptor
    Set-Acl -Path $Path -AclObject $itemSecurityDescriptor
}