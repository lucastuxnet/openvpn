#!/bin/bash

# Atualizar os repositórios e instalar o OpenVPN
sudo apt-get update
sudo apt-get install -y openvpn

# Criar diretório para as chaves
mkdir -p /etc/openvpn/keys
cd /etc/openvpn/keys

# Gerar chave estática
sudo openvpn --genkey --secret estatica.key

# Voltar para o diretório do OpenVPN
cd ..

# Criar diretório do servidor se não existir
mkdir -p /etc/openvpn/server
cd /etc/openvpn/server

# Solicitar o IP remoto ao usuário
read -p "Digite o endereço IP remoto: " IP_REMOTO
read -p "Digite o endereço IP_1 do servidor: " IP_1
read -p "Digite o endereço IP_2 do servidor: " IP_2

# Criar arquivo de configuração do servidor
sudo tee servidor.conf > /dev/null <<EOL
dev tun
remote $IP_REMOTO
ifconfig $IP_1 $IP_2
secret /etc/openvpn/keys/estatica.key
port 5050
ping 15
ping-restart 45
ping-timer-rem
persist-tun
persist-key
verb 3
float
EOL

# Rodar o OpenVPN com a configuração criada
sudo openvpn --config /etc/openvpn/server/servidor.conf &
