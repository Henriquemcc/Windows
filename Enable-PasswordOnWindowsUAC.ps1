param(
    
    [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$Reverse
)

.\Set-RegistryKey.ps1 -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Reverse:$Reverse -Value 1