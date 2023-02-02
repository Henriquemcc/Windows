Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "functions", "MyIO", "MyIO.psm1"))

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 18) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object " 0 - Sair"
        Write-Host -Object " 1 - Instalar Android Studio"
        Write-Host -Object " 2 - Instalar Audacity"
        Write-Host -Object " 3 - Instalar Chocolatey"
        Write-Host -Object " 4 - Instalar atalhos de convidado do Google Chrome"
        Write-Host -Object " 5 - Instalar Chromium"
        Write-Host -Object " 6 - Instalar Java"
        Write-Host -Object " 7 - Instalar Firefox ESR"
        Write-Host -Object " 8 - Instalar Gimp"
        Write-Host -Object " 9 - Instalar Git"
        Write-Host -Object "10 - Instalar IntelliJ IDEA"
        Write-Host -Object "11 - Instalar KeePass"
        Write-Host -Object "12 - Instalar KeePassXC"
        Write-Host -Object "13 - Instalar LibreOffice"
        Write-Host -Object "14 - Instalar Nomacs"
        Write-Host -Object "15 - Instalar Paint.net"
        Write-Host -Object "16 - Instalar Peazip"
        Write-Host -Object "17 - Instalar Python"
        Write-Host -Object "18 - Instalar Visual Studio Code"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "Install", "Install-AndroidStudio.ps1"))
    }

    elseif ($opcao -eq 2) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "Install", "Install-Audacity.ps1"))
    }

    elseif ($opcao -eq 3) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Chocolatey.ps1"))
    }

    elseif ($opcao -eq 4) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-ChromeGuestShortcut.ps1"))
    }

    elseif ($opcao -eq 5) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Chromium.ps1"))
    }

    elseif ($opcao -eq 6) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "InstalarJava.ps1"))
    }

    elseif ($opcao -eq 7) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-FirefoxEsr.ps1"))
    }

    elseif ($opcao -eq 8) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Gimp.ps1"))
    }

    elseif ($opcao -eq 9) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Git.ps1"))
    }

    elseif ($opcao -eq 10) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "Install", "Install-IntellijIdeaCommunity.ps1"))
    }

    elseif ($opcao -eq 11) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-KeePass.ps1"))
    }

    elseif ($opcao -eq 12) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-KeePassXc.ps1"))
    }

    elseif ($opcao -eq 13) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-LibreOffice.ps1"))
    }

    elseif ($opcao -eq 14) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Nomacs.ps1"))
    }

    elseif ($opcao -eq 15) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-PaintDotNet.ps1"))
    }

    elseif ($opcao -eq 16) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Peazip.ps1"))
    }

    elseif ($opcao -eq 17) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "PortableApps", "Install-Python.ps1"))
    }

    elseif ($opcao -eq 18) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition))), "Install", "Install-VisualStudioCode.ps1"))
    }
}