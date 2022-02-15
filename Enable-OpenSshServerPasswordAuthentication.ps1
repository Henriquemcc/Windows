<#
.SYNOPSIS
    Enables Password Authentication on Open SSH Server.
.DESCRIPTION
    Enables Password Authentication on Open SSH Server.
#>

# Modifying sshd_config file
$filePath = [System.IO.Path]::Combine($env:ProgramData, "ssh", "sshd_config")

$fileContent = Get-Content -Path $filePath

$newFileContent = [System.Collections.ArrayList]::new($fileContent.Length)

foreach ($line in $fileContent) {
    
    if ($line.Contains("PasswordAuthentication")) {
        $newFileContent.Add("PasswordAuthentication yes")
    }

    else {
        $newFileContent.Add($line)
    }
    
}

Out-File -FilePath $filePath -InputObject $newFileContent

# Restarting Open SSH Server service
Restart-Service -Name "sshd"