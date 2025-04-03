# Criando diretorio de instalacao
$programName = "Auto Updater"
$installationFolder = [System.IO.Path]::Combine($env:ProgramFiles, $programName)
New-Item -Path $installationFolder -ItemType Directory -Force

# Copiando script PowerShell
$source = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Resources", "Auto Updater", "Update-SystemSafely.ps1")
$destination = [System.IO.Path]::Combine($installationFolder, "Update-SystemSafely.ps1")
Copy-Item -Path $source -Destination $destination

# Copiando script PowerShell
$source = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "Resources", "Auto Updater", "Daemon.ps1")
$daemon = $destination = [System.IO.Path]::Combine($installationFolder, "Daemon.ps1")
Copy-Item -Path $source -Destination $destination

# Criando Servico
$powershellPath = [System.IO.Path]::Combine($env:SystemRoot, "System32", "WindowsPowerShell", "v1.0", "powershell.exe")
$powershellArgs = "-NonInteractive -NoProfile -ExecutionPolicy Unrestricted -File `"$daemon`""
$description = "Service that automatically updates Windows programs using Winget"

New-Service -Name $programName -BinaryPathName "$powershellPath $powershellArgs" -DisplayName $programName -StartupType Automatic -Description $description

# Iniciando o Serviço
Start-Service -Name $programName