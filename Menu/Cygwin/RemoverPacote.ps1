Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "functions", "MyIO", "MyIO.psm1"))

$pacotes = [System.Collections.ArrayList]::new()

function ListarPacotes {
    Write-Host -Object "Pacotes: [" -NoNewline
    for ($i = 0; $i -lt $pacotes.Count; $i++) {
        Write-Host -Object "`"$($pacotes[$i])`"" -NoNewline
        if ($i + 1 -lt $pacotes.Count) {
            Write-Host -Object ", " -NoNewline
        }
    }
    Write-Host -Object "]"
}

function AdicionarPacote {
    $nomePacote = Read-Host -Prompt "Nome do pacote"
    $confirmacao = Read-Char -Prompt "Deseja adicionar o pacote `"$($nomePacote)`" a lista de pacotes a serem desinstalados? (s/n) "
    if ($confirmacao -eq "s" -or $confirmacao -eq "S") {
        if (-not ($pacotes.Contains($nomePacote))) {
            $pacotes.Add($nomePacote)
        }
    }
}

function EncontrarPacote {
    param(
        [Parameter(Mandatory = $true)][System.String]$PacoteProcurado
    )

    foreach ($pacote in $pacotes) {
        if ($pacote.ToLower() -eq $PacoteProcurado.ToLower()) {
            return $pacote
        }
    }

    return $null
}

function RemoverPacote {
    try {
        $nomePacote = Read-Host -Prompt "Nome do pacote"

        $pacoteEncontrado = EncontrarPacote -PacoteProcurado:$nomePacote

        if ($null -eq $pacoteEncontrado) {
            throw "Não existe o pacote `"$($nomePacote)`""
        }

        $confirmacao = Read-Char -Prompt "Deseja remover o pacote `"$($nomePacote)`" da lista de pacotes a serem desinstalados ? (s/n) "
        if ($confirmacao -eq "s" -or $confirmacao -eq "S") {
            $pacotes.Remove($pacoteEncontrado)
        }
    }
    catch {
        Write-Host -Object:$_
    }
}

function Aplicar {

    try {
        if ($pacotes.Count -eq 0) {
            throw "Não há pacotes a serem desinstalados."
        }

        if ($pacotes.Count -eq 1) {
            $pacotes = $pacotes[0]
        }

        Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($script:MyInvocation.MyCommand.Definition))), "functions", "Cygwin", "Uninstall-CygwinPackage.ps1")) -Global
        Uninstall-CygwinPackage -Packages:$pacotes
    }
    catch {
        Write-Host -Object:$_
    }
}

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 4) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Listar pacotes da lista de pacotes a serem desinstalados"
        Write-Host -Object "2 - Adicionar pacote a lista de pacotes a serem desinstalados"
        Write-Host -Object "3 - Remover pacote da lista de pacotes a serem desinstalados"
        Write-Host -Object "4 - Aplicar"
        $_opcao = Read-Int32
    }

    return $_opcao
}

Write-Host -Object "Menu de desinstalação de pacotes Cygwin"

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        ListarPacotes
    }

    elseif ($opcao -eq 2) {
        AdicionarPacote
    }

    elseif ($opcao -eq 3) {
        RemoverPacote  
    }

    elseif ($opcao -eq 4) {
        Aplicar
    }
}