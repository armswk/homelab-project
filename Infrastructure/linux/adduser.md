# Add User
```jsx
useradd -m -s /bin/bash USERNAME
```

```jsx
passwd USERNAME
```

### usermod

```bash
ln /usr/sbin/usermod /usr/bin

#add in .bashrc
PATH=/usr/sbin:$PATH
```