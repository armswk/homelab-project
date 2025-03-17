```jsx
rsync -avz --progress --delete {--chown=smb:users} file.destination user@host:path
```

- `a`, `--archive`, archive mode, equivalent to `rlptgoD`. This option tells `rsync` to syncs directories recursively, transfer special and block devices, preserve symbolic links, modification times, groups, ownership, and permissions.
- `z`, `--compress`. This option forces `rsync` to compresses the data as it is sent to the destination machine. Use this option only if the connection to the remote machine is slow.
- `P`, equivalent to `-partial --progress`. When this option is used, `rsync` shows a progress bar during the transfer and keeps the partially transferred files. It is useful when transferring large files over slow or unstable network connections.
- `--delete`. When this option is used, `rsync` deletes extraneous files from the destination location. It is useful for mirroring.
- `q`, `--quiet`. Use this option if you want to suppress non-error messages.
- `e`. This option allows you to choose a different remote shell. By default, `rsync` is configured to use ssh.

## through server gateway

```jsx
rsync -Pav file -e "ssh user_gateway@host_ip_gateway ssh" user_destination@host_ip_destination ssh:/folder/path
```