Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 24) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object " 0 - Sair"
        Write-Host -Object " 1 - Instalar instalação padrao"
        Write-Host -Object " 2 - Instalar Ccleaner (utilitario de limpeza)"
        Write-Host -Object " 3 - Instalar/Reinstalar Bloatware"
        Write-Host -Object " 4 - Instalar Open SSH Server"
        Write-Host -Object " 5 - Instalar Android Studio"
        Write-Host -Object " 6 - Instalar Audacity"
        Write-Host -Object " 7 - Instalar Chocolatey"
        Write-Host -Object " 8 - Instalar atalhos de convidado do Google Chrome"
        Write-Host -Object " 9 - Instalar Chromium"
        Write-Host -Object "10 - Instalar Eclipse Temurin 8"
        Write-Host -Object "11 - Instalar Eclipse Temurin 11"
        Write-Host -Object "12 - Instalar Eclipse Temurin 17"
        Write-Host -Object "13 - Instalar Firefox ESR"
        Write-Host -Object "14 - Instalar Gimp"
        Write-Host -Object "15 - Instalar Git"
        Write-Host -Object "16 - Instalar IntelliJ IDEA"
        Write-Host -Object "17 - Instalar KeePass"
        Write-Host -Object "18 - Instalar KeePassXC"
        Write-Host -Object "19 - Instalar LibreOffice"
        Write-Host -Object "20 - Instalar Nomacs"
        Write-Host -Object "21 - Instalar Paint.net"
        Write-Host -Object "22 - Instalar Peazip"
        Write-Host -Object "23 - Instalar Python"
        Write-Host -Object "24 - Instalar Visual Studio Code"
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
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Ccleaner.ps1"))
    }

    elseif ($opcao -eq 3) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "ReinstalarBloatware.ps1"))
    }

    elseif ($opcao -eq 4) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-OpenSshServer.ps1"))
    }

    elseif ($opcao -eq 5) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-AndroidStudio.ps1"))
    }

    elseif ($opcao -eq 6) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Audacity.ps1"))
    }

    elseif ($opcao -eq 7) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Chocolatey.ps1"))
    }

    elseif ($opcao -eq 8) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-ChromeGuestShortcut.ps1"))
    }

    elseif ($opcao -eq 9) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Chromium.ps1"))
    }

    elseif ($opcao -eq 10) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 8
    }

    elseif ($opcao -eq 11) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 11
    }

    elseif ($opcao -eq 12) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-EclipseTemurin.ps1")) -Version 17
    }

    elseif ($opcao -eq 13) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-FirefoxEsr.ps1"))
    }

    elseif ($opcao -eq 14) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Gimp.ps1"))
    }

    elseif ($opcao -eq 15) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Git.ps1"))
    }

    elseif ($opcao -eq 16) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-IntellijIdeaCommunity.ps1"))
    }

    elseif ($opcao -eq 17) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-KeePass.ps1"))
    }

    elseif ($opcao -eq 18) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-KeePassXc.ps1"))
    }

    elseif ($opcao -eq 19) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-LibreOffice.ps1"))
    }

    elseif ($opcao -eq 20) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Nomacs.ps1"))
    }

    elseif ($opcao -eq 21) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-PaintDotNet.ps1"))
    }

    elseif ($opcao -eq 22) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Peazip.ps1"))
    }

    elseif ($opcao -eq 23) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-Python.ps1"))
    }

    elseif ($opcao -eq 24) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "PortableApps", "Install-VisualStudioCode.ps1"))
    }
}