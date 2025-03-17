## Redeem the Storage

Select Node

Select Storage

Delete LVM Storage

Go to shell

```
lvremove /dev/pve/data && lvresize -l +100%FREE /dev/pve/root && resize2fs /dev/mapper/pve-root
```

Post install

```
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/post-pve-install.sh)"
```

pass through storage

```
lsblk -o +MODEL, SERIAL

ls /dev/disk/by-id
qm set [node_id] -scsi1 /dev/disk/by-id/ *HDD_Serial*
```

nfs doesnt show after mount

```bash
#to disable it
pvesm set <storage> --disable 1  
#to enable it
--disable 0 

mount -o remount /mnt/pve/[path]
umount -f /mnt/pve/[path]
mount /mnt/pve/[path]
```

# VNC

```bash
/etc/pve/local/qemu-server/<VMID>
args: -vnc 0.0.0.0:77
```