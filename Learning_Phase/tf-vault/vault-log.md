Step 0:
    - kubectl create namespace vault
    - kubectl get all --namespace vault
    - helm repo add hashicorp https://helm.releases.hashicorp.com
    - helm search repo hashicorp/vault

Step 1: Prepare NFS for Backups
    - NFS Server

Step 2: Create PV + PVC for NFS Backup
    - vault-nfs-backup-pv.yaml && vault-nfs-backup-pvc.yaml
    ``
    kubectl apply -f vault-nfs-backup-pv.yaml
    kubectl apply -f vault-nfs-backup-pvc.yaml
    ``


Step 3: Deploy Vault with Helm (Raft Storage)
    - values.yaml
    ``
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm repo update
    helm install vault hashicorp/vault -n vault --create-namespace -f values.yaml
    ``

Step 4: Expose Vault UI with Traefik IngressRoute
    - vault-ingress.yaml

    ``
    kubectl apply -f vault-ingress.yaml
    ``

Command
- kubectl exec -n vault vault-0 -- vault operator init
- kubectl exec -n vault vault-0 -- vault status
- kubectl exec -n vault vault-0 -- vault operator unseal <key>
- kubectl port-forward svc/vault 8200:8200 -n vault
- kubectl logs vault-0 -n vault
- helm upgrade --namespace=vault vault hashicorp/vault --values=values.yaml
- kubectl get secret local-narybits-site-tls -n default -o yaml | sed 's/namespace: default/namespace: vault/' | kubectl apply -f -
- kubectl get secret local-narybits-site-tls -n vault

