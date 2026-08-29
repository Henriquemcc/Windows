# https://www.howtogeek.com/826967/how-to-disable-bing-in-the-windows-11-start-menu/

param(
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$RestoreDefault
)

$path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
$name = "DisableSearchBoxSuggestions"

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

if ($RestoreDefault) {
    $value = 0   
}
else {
    $value = 1
}

New-ItemProperty -Path $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null