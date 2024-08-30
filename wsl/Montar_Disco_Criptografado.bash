#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root "$@"

# Listando os discos
lsblk

# Obtendo disco a ser montado
read -r -p "Selecione o disco a ser montado (exemplo: '/dev/sdX1'): " disco
if [ -z "$disco" ]; then
    exit 1
fi

# Obtendo confirmação
read -r -p "Tem certeza que deseja montar o disco $disco? (s/n) " confirmacao

# Retornando caso a confirmação não seja verdadeira
if [ "${confirmacao:0:1}" != "s" ]; then
    exit 0
fi

# Obtendo o nome do destino_criptografado
read -r -p "Digite o nome do destino criptografado (padrão: 'encrypted'): " destino_criptografado
if [ -z "$destino_criptografado" ]; then
    destino_criptografado="encrypted"
fi

# Obtendo confirmação
read -r -p "Tem certeza que deseja utilizar o destino criptografado $destino_criptografado? (s/n) " confirmacao

# Retornando caso a confirmação não seja verdadeira
if [ "${confirmacao:0:1}" != "s" ]; then
    exit 0
fi

# Obtendo o nome da partição
read -r -p "Digite o nome da partição (padrão: 'encrypted_partition'): " nome_particao
if [ -z "$nome_particao" ]; then
    nome_particao="encrypted_partition"
fi

# Obtendo confirmação
read -r -p "Tem certeza que deseja utilizar o seguinte nome para a partição: $nome_particao? (s/n) " confirmacao

# Retornando caso a confirmação não seja verdadeira
if [ "${confirmacao:0:1}" != "s" ]; then
    exit 0
fi

# Descriptografando
cryptsetup luksOpen "$disco" "$destino_criptografado"

# Criando pasta para o disco
mkdir -p "/mnt/${nome_particao}"

# Montando o disco
mount "/dev/mapper/$destino_criptografado" "/mnt/${nome_particao}"
