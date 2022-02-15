function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 5) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Definir permissoes do arquivo de chaves de administradores permitidas"
        Write-Host -Object "2 - Habilitar autenticacao por Chave publica"
        Write-Host -Object "3 - Desabilitar autenticacao por Chave publica"
        Write-Host -Object "4 - Habilitar autenticacao por senha"
        Write-Host -Object "5 - Desabilitar autenticacao por senha"
        $_opcao = ./Read-Int32.ps1
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\Set-OpenSshAdministratorAuthorizedKeysPermissions.ps1
    }

    elseif ($opcao -eq 2) {
        .\Enable-OpenSshServerPublicKeyAuthentication.ps1
    }

    elseif ($opcao -eq 3) {
        .\Disable-OpenSshServerPublicKeyAuthentication.ps1
    }

    elseif ($opcao -eq 4) {
        .\Enable-OpenSshServerPasswordAuthentication.ps1
    }

    elseif ($opcao -eq 5) {
        .\Disable-OpenSshServerPasswordAuthentication.ps1
    }

}