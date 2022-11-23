Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 3) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Instalar Eclipse Temurin 8"
        Write-Host -Object "2 - Instalar Eclipse Temurin 11"
        Write-Host -Object "3 - Instalar Eclipse Temurin 17"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 8
    }

    elseif ($opcao -eq 2) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 11
    }

    elseif ($opcao -eq 3) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 17
    }
}