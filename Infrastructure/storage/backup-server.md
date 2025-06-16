## Install packages
sudo apt update
sudo apt install cockpit nfs-common samba

## Other packages for cockpit
- [45Drives Cockpit File Sharing](https://github.com/45Drives/cockpit-file-sharing)
- [45Drives Cockpit Navigator](https://github.com/45Drives/cockpit-navigator)
- [45Drives Cockpit Identities](https://github.com/45Drives/cockpit-identities)

## For ZFS Packages
apt install zfsutils-linux
apt install linux-headers-$(uname -r) zfs-dkms zfsutils-linux
