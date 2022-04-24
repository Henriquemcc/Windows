Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 1) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Atualizar ajuda do PowerShell"
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        Update-Help -Force -ErrorAction Ignore
    }

    
}