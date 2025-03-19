# https://www.howtogeek.com/759449/how-to-get-full-context-menus-in-windows-11s-file-explorer/

param(
    [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$RestoreDefault
)

# Check if windows version is greater or equal to 11
if ([System.Environment]::OSVersion.Version.Build -lt 22000) {
    return "Windows version is lower than 11!"
}

if ($RestoreDefault) {
    Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force
    Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force
} else {
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Value "" -Force
}