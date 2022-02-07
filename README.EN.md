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