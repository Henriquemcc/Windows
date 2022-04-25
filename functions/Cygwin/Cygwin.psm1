$files = Get-ChildItem -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -File
$files = $files.Where{
    $_.Name.EndsWith(".ps1")
}

foreach ($file in $files)
{
    . $file.FullName
}