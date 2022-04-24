Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "Chocolatey", "Chocolatey.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 4) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Remover malware"
        Write-Host -Object "2 - Remover Chocolatey (gerenciador de pacotes)"
        Write-Host -Object "3 - Remover bloatware"
        Write-Host -Object "4 - Remover Open SSH Server"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\RemoverMalware.ps1 
    }

    elseif ($opcao -eq 2) {
        Uninstall-Chocolatey
    }

    elseif ($opcao -eq 3) {
        .\RemoverBloatware.ps1
    }

    elseif ($opcao -eq 4) {
        .\Uninstall-OpenSshServer.ps1
    }
}