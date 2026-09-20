# Carrega as variáveis do arquivo .env, se ele existir
if (Test-Path .env) {
    Get-Content .env | Where-Object { $_ -and -not $_.StartsWith("#") } | ForEach-Object {
        $name, $value = $_ -split '=', 2
        [System.Environment]::SetEnvironmentVariable($name, $value)
    }
}

# Obtém a variável de ambiente GITHUB_USERNAME
$GITHUB_USERNAME = $env:GITHUB_USERNAME

# Se a variável estiver vazia, solicita ao usuário e salva no .env
if ([string]::IsNullOrWhiteSpace($GITHUB_USERNAME)) {
    $GITHUB_USERNAME = Read-Host "Enter your GitHub username"
    Add-Content -Path .env -Value "GITHUB_USERNAME=$GITHUB_USERNAME"
}

# Obtendo o caminho do arquivo no qual será salvo as chaves públicas do GitHub
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    $sshDir = Join-Path $ENV:ProgramData "ssh"
    $authKeysPath = Join-Path $sshDir "administrators_authorized_keys"
} else {
    # Define o caminho do diretório .ssh e do arquivo authorized_keys
    $sshDir = Join-Path $HOME ".ssh"
    $authKeysPath = Join-Path $sshDir "authorized_keys"
}

# Garante que o diretório exista
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir | Out-Null
}

# Baixa as chaves públicas do GitHub e adiciona ao authorized_keys
Invoke-RestMethod -Uri "https://github.com/${GITHUB_USERNAME}.keys" | Out-File -FilePath $authKeysPath -Append -Encoding utf8

# Ajusta as permissões no Windows (Equivalente ao chmod 600)
# Desativa a herança e remove outros usuários
if (-not ($isAdmin)) {
    icacls.exe $authKeysPath /inheritance:r /grant:r "$($env:USERNAME):(F)"
}