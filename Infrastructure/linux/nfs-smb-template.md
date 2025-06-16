

# NFS
## Server side
```bash
no_subtree_check,insecure,fsid=0,no_root_squash

#with root owner
rw,sync,no_root_squash,no_subtree_check,anonuid=1000,anongid=100
#without root owner
rw,sync,root_squash,no_subtree_check,anonuid=1000,anongid=100
#current setup
rw,sync,all_squash,no_subtree_check,anonuid=1000,anongid=100
```
## Mount nfs
### Temporary
```bash
sudo mount -t nfs <NFS_SERVER_IP_OR_HOST>:/export/path /mnt/nfs_test
```

### /etc/fstab
```bash
<NFS_SERVER_IP_OR_HOST>:/export/path  /mnt/nfs  nfs  defaults,_netdev,vers=4.2  0  0
```

# SMB
```
map acl inherit = yes
vfs objects = acl_xattr
force user = smb
directory mask = 0775
create mask = 0664
force group = users
```