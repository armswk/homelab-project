NFS

```bash
no_subtree_check,insecure,fsid=0,no_root_squash

#with root owner
rw,sync,no_root_squash,no_subtree_check,anonuid=1000,anongid=100
#without root owner
rw,sync,root_squash,no_subtree_check,anonuid=1000,anongid=100
```