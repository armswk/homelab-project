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
- [x] Install K3S 
- [] config traefik as reverse proxy

# Log

## Date
24/02/2025
install k3s and config MetalLB for External IP Assignment, additionally create a sshmenu script for personal ssh portal