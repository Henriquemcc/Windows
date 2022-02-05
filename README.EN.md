[Versão em Português](README.md)

# Workstation with Windows

This repository contains the setup and installation scripts for the programs I use on my Windows 10 machine.

## How to run

1. From **Start** menu, type **PowerShell**, and then click with the right button in **Windows PowerShell** and then in **Run as administrator**.

2. Copy the following command:

```
Set-ExecutionPolicy Unrestricted -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Henriquemcc/Windows/main/Iniciar.ps1'))
```

3. On **Windows PowerShell** opened window, paste the copied text and press Enter.

## Registry keys changes

This script changes the following Windows registry settings:

[Retpoline Spectre Mitigation](https://www.bleepingcomputer.com/news/security/boost-windows-10-performance-with-retpoline-spectre-mitigation/).

[Windows 10 make UAC always require password](https://superuser.com/questions/1085680/windows-10-make-uac-always-require-password).

[How to Fix Windows and Linux Showing Different Times When Dual Booting](https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/#google_ads_iframe_/10518929/tmnp.howtogeek/article_details/a0-p1-s2_1:~:text=Make%20Windows%20Use%20UTC%20Time%20By%20Editing%20the%20Registry).