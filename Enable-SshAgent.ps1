param(
    [Parameter(Mandatory = $false)] [System.Management.Automation.SwitchParameter]$RestoreDefault
)

if ($RestoreDefault) {
    Set-Service -Name ssh-agent -StartupType Manual
    Stop-Service -Name ssh-agent
}
else {
    Set-Service -Name ssh-agent -StartupType Automatic
    Start-Service -Name ssh-agent
}