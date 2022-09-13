# Infrastructure

All the services deployed on the NAS in one stack. Services that live on the NAS are infrastructure related (databases, mqtt client, vpn) or are things that require direct file access (transmission, trilium) that I want on redundant storage.

Only service not included is Portainer which is installed via unRaid's community apps (easier to get an interface to run the stack with this way)

Goal here is to have all the more background type stuff in one place on a server that is more likely to be up

- Traefik
- Pihole
- NordVPN
- Wireguard (soon)
- Transmission
- Postgres
- pgAdmin
- Prowlarr
- Sonarr
- Radarr
- Lidarr
- Readarr
- Calibre
- Calibre-web
- Trilium
- Mosquitto
