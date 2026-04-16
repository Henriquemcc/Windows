function Get-SshPublicKeysFromGithub{
    param(
        [Parameter(Mandatory = $true, Position = 0)][System.String]$GitHubUserName
    )

    <#
    .SYNOPSIS
        Obtains SSSH Public Keys From a GitHub User.
    .DESCRIPTION
        Obtains SSSH Public Keys From a GitHub User.
    .PARAMETER GitHubUserName
        GitHub username to download its public keys.
    #>

    # Downloading Public Keys
    $publicKeys = Invoke-WebRequest -Uri "https://github.com/${GITHUB_USERNAME}.keys"

    # Saving Public Keys to administrators_authorized_keys file
    $publicKeys = $publicKeys.Content
    $publicKeysFilePath = [System.IO.Path]::Combine($env:ProgramData, "ssh", "administrators_authorized_keys")
    $publicKeys | Out-File -FilePath $publicKeysFilePath -Append

    # Restarting Open SSH Server service
    Restart-Service -Name "sshd"
}