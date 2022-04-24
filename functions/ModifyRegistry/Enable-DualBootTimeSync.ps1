# https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/#google_ads_iframe_/10518929/tmnp.howtogeek/article_details/a0-p1-s2_1:~:text=Make%20Windows%20Use%20UTC%20Time%20By%20Editing%20the%20Registry

function Enable-DualBootTimeSync
{
    param(
        [Parameter(Mandatory = $false)][System.Management.Automation.SwitchParameter]$RestoreDefault
    )

    if ($RestoreDefault)
    {
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name  "RealTimeIsUniversal" -Force
    }
    else
    {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Value 1 -Force
    }
}