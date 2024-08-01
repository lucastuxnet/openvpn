# Interface da VPN
dev tun

# Endereço IP de Internet do servidor
remote 192.168.100.25

# Endereço IP servidor/filial
ifconfig 10.10.10.2 10.10.10.1

# Porta VPN
port 1194

# Parâmetros de ping em ms
ping 15
ping-restart 45
ping-timer-rem

# Mantém a interface tun carregada quando a VPN é reiniciada
persist-tun

# Mantém a chave carregada quando a VPN é reiniciada
persist-key

# Nível do log
verb 3

# Caso o IP mude, o túnel continua estabelecido
float

# Autenticação por fingerprint
peer-fingerprint sha256 <fingerprint-do-cliente>
