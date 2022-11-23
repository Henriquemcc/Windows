Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)), "functions", "MyIO", "MyIO.psm1"))

# https://www.makeuseof.com/tag/easily-remove-bloatware-windows-10/

# https://www.howtogeek.com/224798/how-to-uninstall-windows-10s-built-in-apps-and-how-to-reinstall-them/#:~:text=Use%20PowerShell%20to,can%E2%80%99t%20be%20removed.

function ObterOpcao {

    $_opcao = -1
    while ($_opcao -lt 0 -or $_opcao -gt 18) {
        Write-Host -Object "O que deseja fazer?"
        Write-Host -Object " 0 - Sair"
        Write-Host -Object " 1 - Remover: Microsoft Bing Weather"
        Write-Host -Object " 2 - Remover: Microsoft Bio Enrollment"
        Write-Host -Object " 3 - Remover: Microsoft Getstarted"
        Write-Host -Object " 4 - Remover: Microsoft Office Hub"
        Write-Host -Object " 5 - Remover: Microsoft Office OneNote"
        Write-Host -Object " 6 - Remover: Microsoft People"
        Write-Host -Object " 7 - Remover: Microsoft Solitaire Collection"
        Write-Host -Object " 8 - Remover: Microsoft Windows Alarms"
        Write-Host -Object " 9 - Remover: Microsoft Windows Calculator"
        Write-Host -Object "10 - Remover: Microsoft Windows Camera"
        Write-Host -Object "11 - Remover: Microsoft Windows Maps"
        Write-Host -Object "12 - Remover: Microsoft Windows Photos"
        Write-Host -Object "13 - Remover: Microsoft Windows Store"
        Write-Host -Object "14 - Remover: Microsoft Xbox App"
        Write-Host -Object "15 - Remover: Microsoft Xbox Game Callable UI"
        Write-Host -Object "16 - Remover: Microsoft Xbox Identity Provider"
        Write-Host -Object "17 - Remover: Microsoft Zune Music"
        Write-Host -Object "18 - Reinstalar Bloatware"
        
        $_opcao = Read-Int32
    }

    return $_opcao
}

$opcao = -1
while ($opcao -ne 0) {
    $opcao = ObterOpcao

    if ($opcao -eq 1) {
        Get-AppxPackage -Name "Microsoft.BingWeather" | Remove-AppxPackage
    }

    elseif ($opcao -eq 2) {
        Get-AppxPackage -Name "Microsoft.BioEnrollment" | Remove-AppxPackage
    }

    elseif ($opcao -eq 3) {
        Get-AppxPackage -Name "Microsoft.Getstarted" | Remove-AppxPackage
    }

    elseif ($opcao -eq 4) {
        Get-AppxPackage -Name "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage
    }

    elseif ($opcao -eq 5) {
        Get-AppxPackage -Name "Microsoft.Office.OneNote" | Remove-AppxPackage
    }

    elseif ($opcao -eq 6) {
        Get-AppxPackage -Name "Microsoft.People" | Remove-AppxPackage
    }

    elseif ($opcao -eq 7) {
        Get-AppxPackage -Name "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage
    }

    elseif ($opcao -eq 8) {
        Get-AppxPackage -Name "Microsoft.WindowsAlarms" | Remove-AppxPackage
    }

    elseif ($opcao -eq 9) {
        Get-AppxPackage -Name "Microsoft.WindowsCalculator" | Remove-AppxPackage    
    }

    elseif ($opcao -eq 10) {
        Get-AppxPackage -Name "Microsoft.WindowsCamera" | Remove-AppxPackage
    }

    elseif ($opcao -eq 11) {
        Get-AppxPackage -Name "Microsoft.WindowsMaps" | Remove-AppxPackage
    }

    elseif ($opcao -eq 12) {
        Get-AppxPackage -Name "Microsoft.Windows.Photos" | Remove-AppxPackage
    }

    elseif ($opcao -eq 13) {
        Get-AppxPackage -Name "Microsoft.WindowsStore" | Remove-AppxPackage
    }

    elseif ($opcao -eq 14) {
        Get-AppxPackage -Name "Microsoft.XboxApp" | Remove-AppxPackage
    }

    elseif ($opcao -eq 15) {
        Get-AppxPackage -Name "Microsoft.XboxGameCallableUI" | Remove-AppxPackage
    }

    elseif ($opcao -eq 16) {
        Get-AppxPackage -Name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
    }

    elseif ($opcao -eq 17) {
        Get-AppxPackage -Name "Microsoft.ZuneMusic" | Remove-AppxPackage
    }

    elseif ($opcao -eq 18) {
        & ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "ReinstalarBloatware.ps1"))
    }
}