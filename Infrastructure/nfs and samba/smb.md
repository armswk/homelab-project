### 1. Install the necessary packages:

```docker
sudo apt-get install cifs-utils
```

### 2. Create a mount point for the SMB share:

```docker
sudo mkdir /mnt/smb
```

### 3. Create a file to store the SMB share's username and password:

```docker
sudo nano /etc/.smbcredentials
```

### 4. Add the following lines to the file, replacing **`<smb_username>`** and **`<smb_password>`** with the actual username and password for the SMB share:

```docker
username=<smb_username>
password=<smb_password>
```

### 5. Save and close the file then set the appropriate permissions on the credentials file:

```docker
sudo chmod 600 /etc/.smbcredentials
```

### 6. Mount the SMB share using the credentials file:

```docker
sudo mount -t cifs -o credentials=/etc/.smbcredentials,file_mode=0777,dir_mode=0777 //smb-ip/cloud /mnt/smb
```

Replace **`<lxc_username>`** and **`<lxc_groupname>`** with the username and group name of the user in the LXC container that you want to give write permissions to.

The **`uid`** and **`gid`** options set the ownership of the mount point to the specified user and group in the LXC container, and the **`file_mode=0777,dir_mode=0777`** options give read/write/execute permissions to everyone.

### 7. Test the mount by creating a file or directory in the mount point:

```
sudo touch /mnt/smb/test.txt
```

### 8. To make the mount point persistent across reboots, add an entry to the **`/etc/fstab`** file:

```
//smb-ip/path /mnt/smb cifs credentials=/etc/.smbcredentials,file_mode=0777,dir_mode=0777,x-systemd.automount 0 0
```

Replace **`<smb_server>`** and **`<smb_share>`** with the actual server and share names.

### 9. Save and close the file, and then run the following command to remount all filesystems:

```
mount -a
```

### 10. to unmount the smb

```
sudo umount /mnt/smb
```