# Obtendo a lista dos discos do Windows
$discos = GET-CimInstance -query "SELECT * from Win32_DiskDrive"

# Exibindo a lista dos discos
for ($i = 0; $i -lt $discos.Count; $i++) {
    Write-Host -Object "$i - $($discos[$i])"
}

# Obtendo o número do disco
$numeroDisco = Read-Host -Prompt "Digite o número do disco que deseja desmontar: "
try {
    $numeroDisco = [int]$numeroDisco
} catch {
    Write-Host -Object "Número inválido"
    exit
}
if ($numeroDisco -lt 0 -or $numeroDisco -ge $discos.Count) {
    Write-Host -Object "Número inválido"
    exit
}

# Obtendo a confirmação do usuário
$confirmacao = Read-Host -Prompt "Tem certeza que deseja desmontar o disco $($discos[$numeroDisco])? (s/n)"
if ($confirmacao.ToLower()[0] -eq "s") {
    wsl --unmount $($discos[$numeroDisco].DeviceID)
}