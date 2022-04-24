Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "OpenSshServer", "OpenSshServer.psm1"))

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
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        Set-OpenSshAdministratorAuthorizedKeysPermissions
    }

    elseif ($opcao -eq 2) {
        Enable-OpenSshServerPublicKeyAuthentication
    }

    elseif ($opcao -eq 3) {
        Disable-OpenSshServerPublicKeyAuthentication
    }

    elseif ($opcao -eq 4) {
        Enable-OpenSshServerPasswordAuthentication
    }

    elseif ($opcao -eq 5) {
        Disable-OpenSshServerPasswordAuthentication
    }

}