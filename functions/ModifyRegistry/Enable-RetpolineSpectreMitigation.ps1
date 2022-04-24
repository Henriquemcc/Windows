# https://www.bleepingcomputer.com/news/security/boost-windows-10-performance-with-retpoline-spectre-mitigation/

function Enable-RetpolineSpectreMitigation
{
    param(
        [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$RestoreDefault
    )

    if ($RestoreDefault)
    {
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverride" -Force
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverrideMask" -Force
    }
    else
    {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverride" -Value 0x400 -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "FeatureSettingsOverrideMask" -Value 0x400 -Force
    }




}