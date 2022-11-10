Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 12) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object "0 - Sair"
        Write-Host -Object "1 - Instalar Chocolatey"
        Write-Host -Object "2 - Instalar atalhos de convidado do Google Chrome"
        Write-Host -Object "3 - Instalar Chromium"
        Write-Host -Object "4 - Instalar Java"
        Write-Host -Object "5 - Instalar Firefox ESR"
        Write-Host -Object "6 - Instalar Gimp"
        Write-Host -Object "7 - Instalar Git"
        Write-Host -Object "8 - Instalar IntelliJ IDEA"
        Write-Host -Object "9 - Instalar KeePass"
        Write-Host -Object "10 - Instalar LibreOffice"
        Write-Host -Object "11 - Instalar Nomacs"
        Write-Host -Object "12 - Instalar Visual Studio Code"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Chocolatey.ps1"))
    }

    elseif ($opcao -eq 2) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-ChromeGuestShortcut.ps1"))
    }

    elseif ($opcao -eq 3) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Chromium.ps1"))
    }

    elseif ($opcao -eq 4) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "InstalarJava.ps1"))
    }

    elseif ($opcao -eq 5) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-FirefoxEsr.ps1"))
    }

    elseif ($opcao -eq 6) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Gimp.ps1"))
    }

    elseif ($opcao -eq 7) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Git.ps1"))
    }

    elseif ($opcao -eq 8) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-IntellijIdeaCommunity.ps1"))
    }

    elseif ($opcao -eq 9) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-KeePass.ps1"))
    }

    elseif ($opcao -eq 10) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-LibreOffice.ps1"))
    }

    elseif ($opcao -eq 11) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Nomacs.ps1"))
    }

    elseif ($opcao -eq 12) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-VisualStudioCode.ps1"))
    }
}