iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 172.16.16.1:8080

sudo ip addr add 172.16.238.15/24 dev eth0

sudo ip route add 192.168.1.0/24 via 10.1.1.10

## Check route is added
ip route show