Running LXC with Priviledge
- Debian Image
- RAM 512MB

Installing Cockpit
```
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/cockpit.sh)"
```

Accessing the dashboard
https://:9090

Next, install the three modules from 45Drives:
- [45Drives Cockpit File Sharing](https://github.com/45Drives/cockpit-file-sharing)
- [45Drives Cockpit Navigator](https://github.com/45Drives/cockpit-navigator)
- [45Drives Cockpit Identities](https://github.com/45Drives/cockpit-identities)

once downloaded, then install (be sure that *.deb in the folder exist only these 3 files)
```
apt install ./*.deb
```

mount
```
nano /etc/pve/lxc/<container_id>.conf
```
add this line
```
mp0: /zpool/data,mp=/mnt/zpvool
```