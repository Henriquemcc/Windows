Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))
Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "RepairWindows", "RepairWindows.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 6) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Reparar Windows automaticamente"
        Write-Host -Object "2 - Reparar imagem do Windows com o DISM (Deployment Image Servicing and Management)"
        Write-Host -Object "3 - Reparar arquivos do sistema com o SFC (System File Checker)"
        Write-Host -Object "4 - Desfragmentar disco"
        Write-Host -Object "5 - Reparar erros do sistema de arquivos com o CHKDSK ('Check Disk')"
        Write-Host -Object "6 - Limpar o sistema"
        $_opcao = Read-Int32
    }

    return $_opcao
}


$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\Repair-Windows.ps1
    }

    elseif ($opcao -eq 2) {
        Repair-SystemImageWithDism
    }

    elseif ($opcao -eq 3) {
        Repair-SystemFilesWithSfc
    }

    elseif ($opcao -eq 4) {
        DefragSystemPartition
    }

    elseif ($opcao -eq 5) {
        Repair-SystemPartition
    }

    elseif ($opcao -eq 6) {
        .\Limpar.ps1
    }
}