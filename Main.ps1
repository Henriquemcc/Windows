function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 3) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Executar instalacao padrao"
        Write-Host -Object "2 - Reparar o Windows"
        Write-Host -Object "3 - Limpar o sistema"
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
        .\Reparar.ps1
    }

    elseif ($opcao -eq 3) {
        .\Limpar.ps1
    }
}