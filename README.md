[English Version](README.EN.md)

# Workstation com Windows

Este repositório contém os scripts de instalação dos meus programas que utilizo em minha máquina com Windows 10.

## Como executar

1. No menu **Iniciar**, digite **PowerShell**, clique com o botão direito em **Windows PowerShell** e depois em **Executar como administrador**.

2. Copie o seguinte comando:

```
Set-ExecutionPolicy Unrestricted -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Henriquemcc/Windows/main/Iniciar.ps1'))
```

3. Na janela aberta do **Windows PowerShell**, cole o texto copiado e pressione Enter.

## Alterações nas chaves de registro

Este script altera as seguintes configurações no registro do Windows:

[Retpoline Spectre Mitigation](https://www.bleepingcomputer.com/news/security/boost-windows-10-performance-with-retpoline-spectre-mitigation/).

[Windows 10 make UAC always require password](https://superuser.com/questions/1085680/windows-10-make-uac-always-require-password).

[How to Fix Windows and Linux Showing Different Times When Dual Booting](https://www.howtogeek.com/323390/how-to-fix-windows-and-linux-showing-different-times-when-dual-booting/#google_ads_iframe_/10518929/tmnp.howtogeek/article_details/a0-p1-s2_1:~:text=Make%20Windows%20Use%20UTC%20Time%20By%20Editing%20the%20Registry).