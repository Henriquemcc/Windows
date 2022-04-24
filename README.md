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