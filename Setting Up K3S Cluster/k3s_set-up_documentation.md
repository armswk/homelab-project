# Installing Kubernetes
ref: https://www.learnlinux.tv/how-to-build-an-awesome-kubernetes-cluster-using-proxmox-virtual-environment/
# Setting up a static IP
edit /etc/network/interfaces

# The primary network interface
```
iface <interface> inet static
        address <ip-address>/24
        gateway <gateway-ip>
```
# Disable SWAP
sudo swapoff -a
edit the /etc/fstab file and comment out the line that corresponds to swap

# Enable bridging

sudo nano /etc/sysctl.conf
net.ipv4.ip_forward=1

# Disable ipv6
nano /etc/sysctl.conf
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.tun0.disable_ipv6 = 1
```

restart the network service
sudo systemctl restart networking
# Install K3S
```
curl -sfL https://get.k3s.io | sh -
k3s kubectl get node 
```

side note: docker is Deprecated for kubernetes, recommend using containerd unless you need to use docker compose
```
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--docker" sh -
```

if it already deployed and I want to switch, you need to reinstall it and make a backup of the state in the folllowing path 
```
sudo cp -r /var/lib/rancher/k3s /var/lib/rancher/k3s-backup
```

# config server internal and external ip for local use
```
sudo mkdir -p /etc/rancher/k3s
sudo nano /etc/rancher/k3s/config.yaml
```
node-ip: "server ip"
node-external-ip: "server ip"

# Use MetalLB for External IP Assignment
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/main/config/manifests/metallb-native.yaml

# Install helm
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```
config the network for helm to communicate k3s
export KUBECONFIG=~/.kube/config
and then edit the ip 
helm ls --all-namespaces