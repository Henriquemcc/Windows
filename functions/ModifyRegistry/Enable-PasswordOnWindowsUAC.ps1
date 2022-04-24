# https://superuser.com/questions/1085680/windows-10-make-uac-always-require-password

function Enable-PasswordOnWindowsUAC
{
    param(
        [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$RestoreDefault
    )

    if ($RestoreDefault)
    {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 5 -Force
    }
    else
    {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 1 -Force
    }
}