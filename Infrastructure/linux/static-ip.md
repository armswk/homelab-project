auto eth0
iface eth0 inet static
    address 10.0.0.2
    netmask 255.255.255.0
    gateway 10.0.0.1
    dns-nameservers 8.8.8.8 8.8.4.4