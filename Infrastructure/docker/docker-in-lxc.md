## Docker in LXC

```java
nano /etc/pve/lxc/<container_id>.conf
```

add the following text

```java
lxc.apparmor.profile: unconfined
lxc.cap.drop:
lxc.mount.entry: /var/run/docker.sock /var/run/docker.sock none bind,create=file
```