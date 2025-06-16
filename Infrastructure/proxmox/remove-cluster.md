## delete dead node
```bash
pvecm status
pvecm delnode <nodename>
```
if membership information has 1 online server

```bash
pvecm expected 1
pvecm status
nano /etc/pve/corosync.conf
```
```bash
nodelist {
    node {
        name: pve
        nodeid: 1
        quorum_votes: 1
        ring0_addr: 10.1.1.5
    }
    node {
        name: pve2
        nodeid: 2
        quorum_votes: 1
        ring0_addr: 10.1.1.6
    }
}
```
delete the offline server
systemctl restart corosync

## delete the old node from the gui
```bash
ls /etc/pve/nodes/
rm -r /etc/pve/nodes/dead-node-name
```