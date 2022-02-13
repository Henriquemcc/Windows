function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 6) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Configurar registro para que o Windows User Account Control exija a senha para rodar um programa como administrador"
        Write-Host -Object "2 - Reverter: 'Configurar registro para que o Windows User Account Control exija a senha para rodar um programa como administrador'"
        Write-Host -Object "3 - Habilitar a correcao retpoline da mitigacao da vulnerabilidade Spectre"
        Write-Host -Object "4 - Reverter: 'Habilitar a correcao retpoline da mitigacao da vulnerabilidade Spectre'"
        Write-Host -Object "5 - Alterar a configuracao de fuso horario para manter sincronizado o horario em computadores dual boot (Windows + Linux)"
        Write-Host -Object "6 - Reverter: 'Alterar a configuracao de fuso horario para manter sincronizado o horario em computadores dual boot (Windows + Linux)'"
        $_opcao = ./Read-Int32.ps1
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        .\Enable-PasswordOnWindowsUAC.ps1
    }

    elseif ($opcao -eq 2) {
        .\Enable-PasswordOnWindowsUAC.ps1 -Reverse
    }

    elseif ($opcao -eq 3) {
        .\Enable-RetpolineSpectreMitigation.ps1
    }

    elseif ($opcao -eq 4) {
        .\Enable-RetpolineSpectreMitigation.ps1 -Reverse
    }

    elseif ($opcao -eq 5) {
        .\Enable-DualBootTimeSync.ps1
    }

    elseif ($opcao -eq 6) {
        .\Enable-DualBootTimeSync.ps1 -Reverse
    }
}