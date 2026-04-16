Import-Module -Name ([System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition), "functions", "OpenSshServer", "OpenSshServer.psm1"))

# Instalando Open SSH Server
Install-OpenSshServer

# Obtendo o nome de usuário do GitHub
$envFile = Get-Content -Path ".env"
$env = $envFile.split('\n')
foreach ($line in $env) {
    $variable, $value = $line.split('=')
    Set-Content -Path env:\$variable -Value $value
}

# Obtendo chaves públicas do GitHub
Get-SshPublicKeysFromGithub -GitHubUserName $env:GITHUB_USERNAME

# Desabilitando autenticação por senha
Disable-OpenSshServerPasswordAuthentication

# Habilitando autenticação por chave pública
Enable-OpenSshServerPublicKeyAuthentication

# Definindo permissões para as chaves públicas de administrador
Set-OpenSshAdministratorAuthorizedKeysPermissions

# Reiniciando o serviço Open SSH Server
Restart-Service -Name "sshd"