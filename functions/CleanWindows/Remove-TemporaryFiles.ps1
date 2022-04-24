function Remove-TemporaryFiles
{
    <#
    .SYNOPSIS
        Removes temporary files.
    .DESCRIPTION
        Removes temporary files.
    #>

    # Adding files and folders to the array
    $files = Get-ChildItem -Path $env:TEMP -Recurse
    $files += Get-ChildItem -Path ([System.IO.Path]::Combine($env:SystemRoot, "Temp")) -Recurse

    # Deleting temporary files
    foreach ($file in $files)
    {
        try
        {
            $file.Delete()
        }
        catch
        {
        }
    }
}