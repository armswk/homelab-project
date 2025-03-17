### install

```jsx
curl -fsSL https://tailscale.com/install.sh | sh
```

### settings

```jsx
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

sudo tailscale up --advertise-routes=ip/24 --advertise-exit-node
```

### running on lxc

[Tailscale in LXC containers](https://tailscale.com/kb/1130/lxc-unprivileged)