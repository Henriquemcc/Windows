function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 3) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Remover malware"
        Write-Host -Object "2 - Remover Chocolatey (gerenciador de pacotes)"
        Write-Host -Object "3 - Remover bloatware"
        
        $_opcao = ./Read-Int32.ps1
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
        .\Uninstall-Chocolatey.ps1
    }

    elseif ($opcao -eq 3) {
        .\RemoverBloatware.ps1
    }
}