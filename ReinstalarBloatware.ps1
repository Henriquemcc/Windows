Import-Module -Name ([System.IO.Path]::Join((Split-Path -Path $MyInvocation.MyCommand.Definition -Parent), "functions", "MyIO", "MyIO.psm1"))

# https://www.howtogeek.com/224798/how-to-uninstall-windows-10s-built-in-apps-and-how-to-reinstall-them/#:~:text=How%20to%20Reinstall,then%20press%20Enter%3A

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 18) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object " 0 - Sair"
        Write-Host -Object " 1 - Reinstalar: Microsoft Bing Weather"
        Write-Host -Object " 2 - Reinstalar: Microsoft Bio Enrollment"
        Write-Host -Object " 3 - Reinstalar: Microsoft Getstarted"
        Write-Host -Object " 4 - Reinstalar: Microsoft Office Hub"
        Write-Host -Object " 5 - Reinstalar: Microsoft Office OneNote"
        Write-Host -Object " 6 - Reinstalar: Microsoft People"
        Write-Host -Object " 7 - Reinstalar: Microsoft Solitaire Collection"
        Write-Host -Object " 8 - Reinstalar: Microsoft Windows Alarms"
        Write-Host -Object " 9 - Reinstalar: Microsoft Windows Calculator"
        Write-Host -Object "10 - Reinstalar: Microsoft Windows Camera"
        Write-Host -Object "11 - Reinstalar: Microsoft Windows Maps"
        Write-Host -Object "12 - Reinstalar: Microsoft Windows Photos"
        Write-Host -Object "13 - Reinstalar: Microsoft Windows Store"
        Write-Host -Object "14 - Reinstalar: Microsoft Xbox App"
        Write-Host -Object "15 - Reinstalar: Microsoft Xbox Game Callable UI"
        Write-Host -Object "16 - Reinstalar: Microsoft Xbox Identity Provider"
        Write-Host -Object "17 - Reinstalar: Microsoft Zune Music"
        Write-Host -Object "18 - Desinstalar Bloatware"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        Get-AppxPackage -AllUsers -Name "Microsoft.BingWeather" | Add-AppxPackage
    }

    elseif ($opcao -eq 2) {
        Get-AppxPackage -AllUsers -Name "Microsoft.BioEnrollment" | Add-AppxPackage
    }

    elseif ($opcao -eq 3) {
        Get-AppxPackage -AllUsers -Name "Microsoft.Getstarted" | Add-AppxPackage
    }

    elseif ($opcao -eq 4) {
        Get-AppxPackage -AllUsers -Name "Microsoft.MicrosoftOfficeHub" | Add-AppxPackage
    }

    elseif ($opcao -eq 5) {
        Get-AppxPackage -AllUsers -Name "Microsoft.Office.OneNote" | Add-AppxPackage
    }

    elseif ($opcao -eq 6) {
        Get-AppxPackage -AllUsers -Name "Microsoft.People" | Add-AppxPackage
    }

    elseif ($opcao -eq 7) {
        Get-AppxPackage -AllUsers -Name "Microsoft.MicrosoftSolitaireCollection" | Add-AppxPackage
    }

    elseif ($opcao -eq 8) {
        Get-AppxPackage -AllUsers -Name "Microsoft.WindowsAlarms" | Add-AppxPackage
    }

    elseif ($opcao -eq 9) {
        Get-AppxPackage -AllUsers -Name "Microsoft.WindowsCalculator" | Add-AppxPackage    
    }

    elseif ($opcao -eq 10) {
        Get-AppxPackage -AllUsers -Name "Microsoft.WindowsCamera" | Add-AppxPackage
    }

    elseif ($opcao -eq 11) {
        Get-AppxPackage -AllUsers -Name "Microsoft.WindowsMaps" | Add-AppxPackage
    }

    elseif ($opcao -eq 12) {
        Get-AppxPackage -AllUsers -Name "Microsoft.Windows.Photos" | Add-AppxPackage
    }

    elseif ($opcao -eq 13) {
        Get-AppxPackage -AllUsers -Name "Microsoft.WindowsStore" | Add-AppxPackage
    }

    elseif ($opcao -eq 14) {
        Get-AppxPackage -AllUsers -Name "Microsoft.XboxApp" | Add-AppxPackage
    }

    elseif ($opcao -eq 15) {
        Get-AppxPackage -AllUsers -Name "Microsoft.XboxGameCallableUI" | Add-AppxPackage
    }

    elseif ($opcao -eq 16) {
        Get-AppxPackage -AllUsers -Name "Microsoft.XboxIdentityProvider" | Add-AppxPackage
    }

    elseif ($opcao -eq 17) {
        Get-AppxPackage -AllUsers -Name "Microsoft.ZuneMusic" | Add-AppxPackage
    }

    elseif ($opcao -eq 18) {
        .\RemoverBloatware.ps1
    }
}