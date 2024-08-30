#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root "$@"

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

# Desmontando o disco
umount "/mnt/${nome_particao}"

# Fechando a criptografia
cryptsetup luksClose "$destino_criptografado"
