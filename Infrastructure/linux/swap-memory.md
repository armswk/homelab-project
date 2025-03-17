## Swap Memory

```java
swapon --show
swapoff -a
mkswap /swapfile

dd if=/dev/zero of=/swapfile bs=**1G** count=4

****chmod 0600 /swapfile	
swapon /swapfile
swapon --show
echo /swapfile none swap defaults 0 0 >> /etc/fstab
```