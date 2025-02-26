# References
- https://www.youtube.com/watch?v=G4CmbYL9UPg
- https://technotim.live/posts/kube-traefik-cert-manager-le/
# Tool
- traefik
- cert manager
- dns provider (cloudflare)

# Instruction
kubectl create namespace traefik
kubectl get namespace
helm repo add traefik https://helm.traefik.io/traefik
helm repo update

edit value.yaml

helm install --namespace=traefik traefik traefik/traefik --values=values.yaml

after deploy and make a changes in values.yaml
helm upgrade --namespace=traefik traefik traefik/traefik --values=values.yaml
 ---
!!There is some problem
K3S will auto deploy traefik so need to disable first
sudo nano /etc/rancher/k3s/config.yaml
and then add
disable:
  - traefik
---

applying for middleware
a blog of config 

kubectl apply -f default-headers.yaml
kubectl get middleware

# Dashboard
Install htpassword

sudo apt-get update
sudo apt-get install apache2-utils

Generate a credential / password that’s base64 encoded
htpasswd -nb techno password | openssl base64

Apply secret
kubectl apply -f secret-dashboard.yaml

Get secret
kubectl get secrets --namespace traefik

Apply middleware
kubectl apply -f middleware.yaml

Apply dashboard
kubectl apply -f ingress.yaml

Visit https://traefik.local.narybits.site

k8s network: ingress secret middleware header
