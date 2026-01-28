# Realizando instalação do Henrique-PC
& ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "InstalarHenriquePC.ps1"))

# Alterando o nome do computador
Rename-Computer -NewName "Henrique-Laptop"