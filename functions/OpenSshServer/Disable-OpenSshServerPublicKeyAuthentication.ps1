﻿function Disable-OpenSshServerPublicKeyAuthentication
{
    <#
    .SYNOPSIS
        Disables Public Key Authentication on Open SSH Server.
    .DESCRIPTION
        Disables Public Key Authentication on Open SSH Server.
    #>

    # Modifying sshd_config file
    $filePath = [System.IO.Path]::Combine($env:ProgramData, "ssh", "sshd_config")

    $fileContent = Get-Content -Path $filePath

    $newFileContent = [System.Collections.ArrayList]::new($fileContent.Length)

    foreach ($line in $fileContent)
    {
        if ( $line.Contains("PubkeyAuthentication"))
        {
            $newFileContent.Add("PubkeyAuthentication no")
        }

        else
        {
            $newFileContent.Add($line)
        }
    }

    Out-File -FilePath $filePath -InputObject $newFileContent -Encoding ascii

    # Restarting Open SSH Server service
    Restart-Service -Name "sshd"
}