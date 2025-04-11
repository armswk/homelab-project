# Understanding "State"
State is data created and used by your application which must not be lost </br>
Type of state
- User-generated data (ie. database)
- Temporary Data (ie. RAM)

# Kubernetes vs Docker Volumes
| Kubernetes Volumes | Docker Volumes |
|---|---|
| Supports many different Drivers and Types | no Driver/Type Support |
|Volumes aren't necessarily persistent | Volume persist until manually cleared |
Volumes survive after Container restarts and remove | Volumes survive after Container restarts and remove | 

for more information </br>
[https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

# Problem deleting PV
| NAME | CAPACITY | ACCESS MODES | RECLAIM POLICY | STATUS | CLAIM | STORAGECLASS | VOLUMEATTRIBUTESCLASS | REASON | AGE |
|---   |---       |---           |---             |---     |---    |---           |---                    |---     |---  |
|nfs-pv| 100Gi    | RWX          | Retain         | Terminating | database/nfs-pvc   | nfs-storage  | <unset>                |        |     |

if stuck terminating try:
```
kubectl get pv [PV-Name] -o json > nfs-pv.json
```
remove   
```
    "finalizers": [
    "kubernetes.io/pv-protection"
```
 and then run this command
```
kubectl patch pv [PV-Name] -p '{"metadata":{"finalizers":null}}' --type=merge
```