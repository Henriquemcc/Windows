function Get-ChildPath
{
    param(
        [Parameter(Mandatory = $true, Position = 0)][System.String]$FullPath,
        [Parameter(Mandatory = $true, Position = 1)][System.String]$ParentPath
    )

    <#
    .SYNOPSIS
        Get the child path from the full path and the parent path.
    .DESCRIPTION
        Obtain the child path from the full path and the parent path. 
    .PARAMETER FullPath
        The complete path.
    .PARAMETER ParentPath
        The parent path.
    .EXAMPLE
        Get-ChildPath -FullPath "C:\Windows\System32\msiexec.exe" -ParentPath "C:\Windows"
        "System32\msiexec.exe"
        In this example, "C:\Windows\System32\msiexec.exe" will have "C:\Windows" removed.
    #>

    # Removing separator character from the end of the full path
    while ($FullPath.EndsWith([System.IO.Path]::DirectorySeparatorChar) -or $FullPath.EndsWith([System.IO.Path]::AltDirectorySeparatorChar))
    {
        $FullPath = $FullPath.Substring(0, $FullPath.Length -1)
    }

    # Removing separator character from the end of the parent path
    while ($ParentPath.EndsWith([System.IO.Path]::DirectorySeparatorChar) -or $ParentPath.EndsWith([System.IO.Path]::AltDirectorySeparatorChar))
    {
        $ParentPath = $ParentPath.Substring(0, $ParentPath.Length -1)
    }

    $arrayFullPath = $FullPath.Split(@([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar))
    $arrayParentPath = $ParentPath.Split(@([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar))
    $childPath = [System.Text.StringBuilder]::new()
    for($i = 0; $i -lt $arrayFullPath.Length; $i++)
    {
        if ($i -lt $arrayParentPath.Length)
        {
            if ($arrayFullPath[$i] -ne $arrayParentPath[$i])
            {
                throw "Parent path is not part of the full Path"
            }
        }
        else
        {
            [void]$childPath.Append($arrayFullPath[$i])
            if ($i + 1 -lt $arrayFullPath.Length)
            {
                [void]$childPath.Append([System.IO.Path]::DirectorySeparatorChar)
            }
        }
    }
    
    return $childPath.ToString()
}