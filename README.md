# homelab-project
Welcome to my homelab Journey </br>
This repo contains all of the configuration and documentation of my homelab

I began working on self-hosting and docker since 2023 and trying to move my infrastructures from docker standalone to kubernetes, to be more expose to enterprise environment.
## My Current Setup
- 1 Proxmox Server for services
- 1 Proxmox Server for PBS
- IONOS for backup
- AWS S3 for static website
## Toolings
- k3s

## List of my running services
Network:
- Speedtest Tracker
- nginx reverse proxy manager
- adguard
- cloudflare tunnel
- tailscale
- wireguard

Monitoring:
- grafana with influxdb(proxmox data query)
- uptime kume

Storage:
- nextcloud
- photoprism
- file browser

Applications:
- homepage dashboard
- 2 Wordpress websites
- gitlab (for CICD)
- S-PDF
- Collabora

## Goals
-[] move from docker compose to Kubernetes 
## TODO/TASK
- [x] Install K3S (26.02.2025)
- [x] config traefik as reverse proxy (27.02.2025)
- [] NFS Server Setup
- [] PostGres or Mariadb Setup

# Log
27.02.2025
- removing CF Key
```
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch applications/traefik-cert-network-manager/cert-manager/issuers/secret-cf-token.yaml" \
  --prune-empty --tag-name-filter cat -- --all
git push origin --force --all
git log -- applications/traefik-cert-network-manager/cert-manager/issuers/secret-cf-token.yaml

## Date
24/02/2025
install k3s and config MetalLB for External IP Assignment, additionally create a sshmenu script for personal ssh portal
