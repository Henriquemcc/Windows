param(   
    [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$Reverse
)

# https://www.bleepingcomputer.com/news/security/boost-windows-10-performance-with-retpoline-spectre-mitigation/

.\Set-RegistryKey.ps1 -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverride" -Value 0x400 -Reverse:$Reverse
.\Set-RegistryKey.ps1 -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverrideMask" -Value 0x400 -Reverse:$Reverse