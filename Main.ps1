function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 6) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Instalar"
        Write-Host -Object "2 - Atualizar"
        Write-Host -Object "3 - Reparar"
        Write-Host -Object "4 - Limpar"
        Write-Host -Object "5 - Remover"
        Write-Host -Object "6 - Configurar"
        $_opcao = ./Read-Int32.ps1
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\Instalar.ps1
    }

    elseif ($opcao -eq 2) {
        .\Atualizar.ps1
    }

    elseif ($opcao -eq 3) {
        .\Reparar.ps1
    }

    elseif ($opcao -eq 4) {
        .\Limpar.ps1
    }

    elseif ($opcao -eq 5) {
        .\Remover.ps1
    }

    elseif ($opcao -eq 6) {
        .\Configurar.ps1
    }
}