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

## Notes

When setting up the services running through the VPN, for container-to-container communication treat them as all running on the same network. All services should be available to each other on localhost with their respective ports.

For the management services I also configured them locally before exposing them. Link all the services together and set up form authentication first thing to make sure nothing sensitive is unprotected.

PUID and PGID must be the user that has control over the media files. I chown'd the whole file tree to make sure that user would have all the permissions it needed, thus giving the containers that do the media file manipulation all the permissions they would need as well.
