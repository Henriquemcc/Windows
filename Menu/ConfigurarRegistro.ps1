Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {
    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 6) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Configurar registro para que o Windows User Account Control exija a senha para rodar um programa como administrador"
        Write-Host -Object "2 - Restaurar padrão: 'Configurar registro para que o Windows User Account Control exija a senha para rodar um programa como administrador'"
        Write-Host -Object "3 - Habilitar a correção retpoline da mitigação da vulnerabilidade Spectre"
        Write-Host -Object "4 - Restaurar padrão: 'Habilitar a correção retpoline da mitigação da vulnerabilidade Spectre'"
        Write-Host -Object "5 - Alterar a configuração de fuso horário para manter sincronizado o horário em computadores dual boot (Windows + Linux)"
        Write-Host -Object "6 - Restaurar padrão: 'Alterar a configuração de fuso horário para manter sincronizado o horário em computadores dual boot (Windows + Linux)'"
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-PasswordOnWindowsUAC.ps1"))
    }

    elseif ($opcao -eq 2) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-PasswordOnWindowsUAC.ps1")) -RestoreDefault
    }

    elseif ($opcao -eq 3) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-RetpolineSpectreMitigation.ps1"))
    }

    elseif ($opcao -eq 4) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-RetpolineSpectreMitigation.ps1")) -RestoreDefault
    }

    elseif ($opcao -eq 5) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-DualBootTimeSync.ps1"))
    }

    elseif ($opcao -eq 6) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Enable-DualBootTimeSync.ps1")) -RestoreDefault
    }
}