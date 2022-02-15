param(   
    [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$Reverse
)

# https://superuser.com/questions/1085680/windows-10-make-uac-always-require-password

.\Set-RegistryKey.ps1 -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Reverse:$Reverse -Value 1