apt-get install build-essential gnupg2 gcc make -y

curl -LO https://www.softether-download.com/files/softether/v4.44-9807-rtm-2025.04.16-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-x64-64bit.tar.gz

tar -xf softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-x64-64bit.tar.gz

cd vpnserver/

./.install.sh

cd ..

 mv vpnserver /usr/local

cd /usr/local/vpnserver/
chmod 600 *
chmod 700 vpncmd
chmod 700 vpnserver

./vpncmd
3 and then check

nano /opt/vpnserver.sh
nano /etc/systemd/system/vpnserver.service

systemctl enable vpnserver
systemctl start vpnserver
systemctl status vpnserver

---- create User ----
/usr/local/vpnserver/vpncmd
press 1
localhost:5555
press enter
ServerPasswordSet
HubCreate <hub_name>
    Create Password that are different to the admin password
Hub <hub_name>
    SecureNatEnable
UserCreate <Username>
UserPasswordSet <Username>
IPSecEnable

IPsecEnable command - Enable or Disable IPsec VPN Server Function
Enable L2TP over IPsec Server Function (yes / no): yes

Enable Raw L2TP Server Function (yes / no): no

Enable EtherIP / L2TPv3 over IPsec Server Function (yes / no): yes

Pre Shared Key for IPsec (Recommended: 9 letters at maximum): whatever

Default Virtual HUB in a case of omitting the HUB on the Username: homelab

The command completed successfully.

# Steps to Create a TAP Interface for SoftEther
1. Install tap kernel module (if not loaded)
bash
sudo modprobe tap
2. Create a new TAP device for SoftEther
bash
sudo ip tuntap add dev tap_softether mode tap
sudo ip link set tap_softether up

Replace tap_softether with any name you prefer.

3. Terminal 
/usr/local/vpnserver/vpncmd
    1. Management of VPN Server or VPN Bridge
    Hostname: localhost
    Hub Name: (press Enter)
    Password: (press Enter if not set)
    BridgeCreate <YourHubName> /DEVICE:tap_softether /TAP:yes
