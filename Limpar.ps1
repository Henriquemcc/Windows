function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 2) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Remover arquivos inuteis com o cleanmgr"
        Write-Host -Object "2 - Remover arquivos temporarios"
        $_opcao = ./Read-Int32.ps1
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\Remove-UselessFilesWithCleanmgr.ps1
    }

    elseif ($opcao -eq 2) {
        .\Remove-TemporaryFiles.ps1
    }
}