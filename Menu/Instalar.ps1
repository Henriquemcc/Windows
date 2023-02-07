Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 5) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Instalar instalação padrao"
        Write-Host -Object "2 - Instalar Chocolatey (gerenciador de pacotes)"
        Write-Host -Object "3 - Instalar Ccleaner (utilitario de limpeza)"
        Write-Host -Object "4 - Instalar/Reinstalar Bloatware"
        Write-Host -Object "5 - Instalar Open SSH Server"
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "InstalacaoPadrao.ps1"))
    }

    elseif ($opcao -eq 2) {
        Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "Chocolatey", "Install-Chocolatey.ps1"))
        Install-Chocolatey
    }

    elseif ($opcao -eq 3) {
        Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "CleanWindows", "Install-Ccleaner.ps1"))
        Install-Ccleaner
    }

    elseif ($opcao -eq 4) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "ReinstalarBloatware.ps1"))
    }

    elseif ($opcao -eq 5) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "Install", "Install-OpenSshServer.ps1"))
    }
}