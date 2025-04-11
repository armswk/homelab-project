# 🛡️ Vault on K3s with Secure Raft Backup to NFS

This guide walks you through:

1. Installing Vault via Helm in a K3s cluster using Raft
2. Exposing Vault UI via Traefik
3. Setting up a secure backup process to NFS using Kubernetes Auth (no root token exposure)

---

## 🚀 Step 0: Set Up Namespace & Helm Repo

```bash
kubectl create namespace vault
kubectl get all --namespace vault

helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault
```

---

## 📁 Step 1: Prepare NFS for Backups

Ensure an NFS server is available and reachable from your K3s nodes.

- Example NFS Path: `/export/vault-backups`
- Example NFS Server IP: `10.7.7.110`

---

## 📦 Step 2: Create PV + PVC for NFS Backup

### `vault-nfs-backup-pv.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: vault-backup-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: vault-nfs
  nfs:
    path: /export/vault-backups
    server: 10.7.7.110
```

### `vault-nfs-backup-pvc.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: vault-backup-pvc
  namespace: vault
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: vault-nfs
```

```bash
kubectl apply -f vault-nfs-backup-pv.yaml
kubectl apply -f vault-nfs-backup-pvc.yaml
```

---

## 📥 Step 3: Deploy Vault with Helm (Raft Mode)

### `values.yaml`

Make sure `VAULT_CONFIG_PATH` points to a mounted ConfigMap, and no `config:` block is used directly.

```bash
helm repo update
helm install vault hashicorp/vault -n vault --create-namespace -f values.yaml
```

---

## 🌐 Step 4: Expose Vault UI with Traefik IngressRoute

### `vault-ingress.yaml`

```bash
kubectl apply -f vault-ingress.yaml
```

---

## 🔧 Useful Commands

```bash
#Vault init
kubectl exec -n vault vault-0 -- vault operator init
kubectl exec -n vault vault-0 -- vault operator unseal <key>
kubectl exec -n vault vault-0 -- vault status
kubectl port-forward svc/vault 8200:8200 -n vault
kubectl logs vault-0 -n vault

#Helm upgrade
helm upgrade --namespace=vault vault hashicorp/vault --values=values.yaml

#Copy SSL Certificate 
kubectl get secret local-narybits-site-tls -n default -o yaml | sed 's/namespace: default/namespace: vault/' | kubectl apply -f -
kubectl get secret local-narybits-site-tls -n vault

# Fix Windows line endings if needed
dos2unix values.yaml  

# Check/Test wheather vault:8200 is reachable
kubectl run curl-test -n vault --rm -it \
  --image=alpine --command -- sh
## with curl
apk add --no-cache curl
curl -v http://vault:8200/v1/sys/health
## with telnet
apk add busybox-extras
telnet vault 8200


```

---

# 🔐 Secure Vault Raft Backups via Kubernetes Auth

## 1. Enable Kubernetes Auth in Vault

```bash
export VAULT_TOKEN=
vault auth enable kubernetes
```

---

## 2. Create Snapshot Policy

### `snapshot-policy.hcl`

```hcl
path "sys/storage/raft/snapshot" {
  capabilities = ["read", "create", "update"]
}
```

```bash
vault policy write snapshot snapshot-policy.hcl
```

---

## 3. Create Vault Role for Kubernetes ServiceAccount

```bash
vault write auth/kubernetes/role/vault-backup \
  bound_service_account_names=vault-backup \
  bound_service_account_namespaces=vault \
  policies=snapshot \
  ttl=15m
```

---

## 4. Create ServiceAccount in Kubernetes

### `vault-backup-serviceaccount.yaml`

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: vault-backup
  namespace: vault
  annotations:
    vault.hashicorp.com/role: "vault-backup"
```

```bash
kubectl apply -f vault-backup-serviceaccount.yaml
```

---

## 5. Deploy Secure Backup CronJob

This job logs in using Kubernetes Auth and writes a snapshot to your mounted NFS.

### `vault-backup-cronjob.yaml`

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: vault-backup
  namespace: vault
spec:
  schedule: "0 * * * *" # every hour
  jobTemplate:
    spec:
      serviceAccountName: vault-backup
      containers:
        - name: vault
          image: hashicorp/vault:1.13.3
          command:
            - /bin/sh
            - -c
            - |
              export VAULT_ADDR=http://vault:8200
              VAULT_TOKEN=$(vault write -field=token auth/kubernetes/login role=vault-backup \
                jwt=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token))
              vault login $VAULT_TOKEN
              vault operator raft snapshot save /vault/backups/snapshot-$(date +%Y%m%d%H%M).snap
          volumeMounts:
            - name: vault-backup
              mountPath: /vault/backups
      restartPolicy: OnFailure
      volumes:
        - name: vault-backup
          persistentVolumeClaim:
            claimName: vault-backup-pvc
```

---

## ✅ Benefits of This Method

| Feature                        | Benefit                                |
|-------------------------------|----------------------------------------|
| 🔐 No root token in Git       | Secrets managed securely               |
| ✅ Vault-native auth           | Uses short-lived tokens via SA         |
| 📦 Automated backups           | Safe recovery snapshots on schedule    |
| 💾 Uses NFS                    | Centralized, persistent storage        |

---

## 🔁 Restoring from Snapshot

```bash
vault operator raft snapshot restore snapshot-<timestamp>.snap
```

---

## 📋 Requirements Recap

- Vault running in Raft mode
- Kubernetes Auth enabled in Vault
- NFS PVC available and mounted to `/vault/backups`

---

Made with ❤️ for zero-downtime secrets management and secure automation.
```

---