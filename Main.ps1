Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 8) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Instalar"
        Write-Host -Object "2 - Atualizar"
        Write-Host -Object "3 - Reparar"
        Write-Host -Object "4 - Limpar"
        Write-Host -Object "5 - Remover"
        Write-Host -Object "6 - Configurar"
        Write-Host -Object "7 - Parar"
        Write-Host -Object "8 - Portable Apps"
        $_opcao = Read-Int32
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
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Menu", "Atualizar.ps1"))
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

    elseif ($opcao -eq 7) {
        .\Parar.ps1
    }

    elseif ($opcao -eq 8) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Menu", "PortableApps", "Principal.ps1"))
    }
}