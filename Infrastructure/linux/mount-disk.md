## Mount Disk

```jsx
lsblk
mount /dev/sdxX /[path]

#alpine EXT4
apk add e2fsprogs
mkfs.ext4 /dev/sdX
```

## fstab

```jsx
nano /etc/fstab
UUID=[blkid] /[mount_path] ext4 defaults 0 0
```