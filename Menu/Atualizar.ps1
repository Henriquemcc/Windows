Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao
{

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 2)
    {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Atualizar ajuda do PowerShell"
        Write-Host -Object "2 - Atualizar todos os pacotes Chocolatey"
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0)
{
    $opcao = ObterOpcao

    if ($opcao -eq 1)
    {
        Update-Help -Force -ErrorAction Ignore
    }

    if ($opcao -eq 2)
    {
        Import-Module -Name ([System.IO.Path]::Combine((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "Chocolatey", "Chocolatey.psm1"))
        Upgrade-ChocolateyPackage -ConfirmAllPrompts
    }
}