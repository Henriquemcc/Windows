Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))
Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "CleanWindows", "CleanWindows.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 3) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Remover arquivos inuteis com o cleanmgr"
        Write-Host -Object "2 - Remover arquivos temporarios"
        Write-Host -Object "3 - Baixar, instalar e executar o Ccleaner"
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        Remove-UselessFilesWithCleanmgr
    }

    elseif ($opcao -eq 2) {
        Remove-TemporaryFiles
    }

    elseif ($opcao -eq 3) {
        Start-Ccleaner
    }
}