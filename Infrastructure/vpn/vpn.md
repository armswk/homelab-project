###### WireGuard Tunnel ######

## install WireGuard ##
apt install wireguard -y

## enbale ip forwarding ##
nano /etc/sysctl.conf

uncomment net.ipv4.ip_forward=1

## apply changes ##
sysctl -p

## generate public and private keys ##
cd /etc/wireguard && umask 077; wg genkey | tee privatekey | wg pubkey > publickey

--> site 1 (server)

## create wg0.conf on server and client side
# see the template in wg0-...-template.conf
nano /etc/wireguard/wg0.conf

## start connection ##
wg-quick up wg0

## show status ##
wg show

######## IP Tables Forwarding  ########

iptables -t nat -A PREROUTING -p tcp --dport 81 -j DNAT --to-destination 172.16.16.1:81

iptables -t nat -A POSTROUTING -j MASQUERADE


######## WireGuard automatisieren ########

## enable on system boot ##
systemctl enable wg-quick@wg0