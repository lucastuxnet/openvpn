#!/bin/bash

# Atualizar os repositórios e instalar o OpenVPN.
sudo apt-get update && \
sudo apt-get install -y openvpn && \

# Criar diretório para as chaves.
sudo mkdir -p /etc/openvpn/keys
cd /etc/openvpn/keys

# Gerando chave estatica.
sudo openvpn --genkey --secret openvpn.key

# Solicitar o IP remoto ao usuário
read -p "Digite o endereço IP_1 do servidor: " IP_1
read -p "Digite o endereço IP_2 do servidor: " IP_2
read -p "Digite o endereço IP remoto: " IP_REMOTO

# Criar arquivo de configuração do servidor
cd /etc/openvpn/server
sudo tee server.conf > /dev/null <<EOL
dev tun
proto udp
ifconfig $IP_1 $IP_2
remote $IP_REMOTO
secret /etc/openvpn/keys/openvpn.key
keepalive 10 120
daemon
EOL

# Adicionando na iptables
sudo iptables -A INPUT -p udp --dport 1194 -j ACCEPT
sudo iptables -A INPUT -i tun+ -j ACCEPT
sudo iptables -A FORWARD -i tun+ -j ACCEPT

# Rodar o OpenVPN com a configuração criada
sudo systemctl start openvpn-server@server
