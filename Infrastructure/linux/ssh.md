```bash
//Client-Computer
ssh-keygen -b 4096 -C "Comment"

//transfer the key to the server
ssh-copy-id SYSUSER@x.x.x.x

//new User
chown -R USER:USER .ssh

//config ssh file
sudo nano /etc/ssh/sshd_config
	1. PermitRootLogin -> no
	2. PasswordAuthentication -> no
sudo systemctl restart ssh

//fix Permission
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
```

### to remove

`ssh-keygen -R "hostname"`

### ssh-copy-id >> Windows

```jsx
cat ~/.ssh/id_rsa.pub | ssh SYSUSER@x.x.x.x 'cat >> ~/.ssh/authorized_keys'
```

### Regenerate SSH host keys

```yaml
rm -v /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
systemctl restart ssh
systemctl status ssh
```

```jsx
ssh-keygen -A
```
## ssh through gatewaz
```jsx
ssh -Pav filename -e "ssh gatewayaddress ssh" destination_address:/.../../
```
## Multiple SSH github key

Ref: https://gist.github.com/oanhnn/80a89405ab9023894df7

edit ~.ssh/config

```bash
Host github.com
   HostName github.com
   IdentityFile ~/.ssh/oanhnn_private_key
   IdentitiesOnly yes
   
# Other github account: superman
Host github-armswk
   HostName github.com
   IdentityFile ~/.ssh/superman_private_key
   IdentitiesOnly yes
```

clone

```bash
git clone git@github-superman:org1/project1.git /path/to/project1
cd /path/to/project1
git config user.email "superman@example.com"
git config user.name  "Super Man"
```