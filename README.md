# server-config

A repo of files to set up my local server running [Ubuntu 20.04 Server](https://ubuntu.com/server/docs/installation).

To achieve a similar set up you must have [Docker](https://docs.docker.com/get-docker/) installed, with Docker Compose recommended. Script included here but it may not run all the way through - each command run separately should do the trick though. Hopefully this will be improved in the future. As an aside, installations on Raspberry Pis seem to be hit or miss, especially with older models - [this article](https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there's%20plenty%20of,can%20also%20install%20Docker%20Compose.) got Docker up and running on an older Pi that was a little more resistant installing with the commands in the included script.

[Portainer](https://www.portainer.io/) is highly recommended as an easy-to-use interface to manage your containers. By and large, each `docker-compose.yml` is deployed as a stack to take advantage of environment variable substitution and to allow control of the configurations through the Portainer interface.

After getting Portainer running, getting Traefik running next is probably the most sensible route to go. Optionally, allowing ssh access makes orchestrating this all remotely much easier. Many of the included `docker-compose.yml` files assume the networking stack is set up and have additional configurations with that mind.

As a side note, many of these setups also include Kubernetes configurations. If that is of interest, there is a corresponding folder that details how a cluster can be created. Due to Portainer's ability to manage Kubernetes clusters, it's likely still useful to have Portainer up and running, if only to add the cluster as an agent endpoint.

## Services

- [Portainer](./services/portainer) - Docker Container and Kubernetes Cluster Management and Orchestration
- [Jenkins](./services/jenkins) - Customizable Build Server
- [Home Assistant](./services/homeassistant) - Home Automation Platform
- [Homepage](./services/homepage) - Simple and Customizable Dashboard for your Services
- [Vikunja](./services/vikunja) - Task Management Platform
- [Trilium](./services/trilium) - OneNote-like Wiki and Notes Platform
- [Firefly III](./services/fireflyiii) - Budgeting and Transaction Tracking
- [Muse](./services/muse) - A Discord music bot
- [n8n](./services/n8n) - An automation platform similar to
- [Transmission](./services/torrent) - Torrenting download client
- [Duplicati](./services/duplicati/) - File backup
- [OpenLDAP](./services/ldap) - User credential backend
- [Grafana](./services/grafana/) - Data visualization
- [Speedtest Tracker](./services/speedtest/) - Continuous Network Speedtests
- [Uptime Kama](./services/uptime/) - Continuous uptime monitoring for websites, ports, and various other services
- [KASM Workspaces](./services/kasm) - Container Streaming Platform
- [Grocy](./services/grocy) - Groceries and household management
- [KitchenOwl](./services/kitchenowl) - Grocery and Recipe management
- [Ntfy](./services/ntfy) - Simple notification service
- [Linkding](./services/linkding) - Bookmark management
- [Dozzle](./services/dozzle) - A light weight service to view logs from docker containers
- [Traggo](./services/traggo) - A simple time tracking service
- [Ghost](./services/ghost) - A simple blogging platform
- [Paperless-NGX](./services/paperless-ngx) - A PDF processing and management server
- [BookBounty](./services/bookbounty) - An application to extend Radarr to allow for automatic querying from Library Genesis
- [Komf](./services/komf) - A metadata service for Kavita
- [LinkStack](./services/linkstack) - A simple LinkTree like service for simple link sharing
- [Pydio Cells](./services/pydio-cells) - A simple file sync platform
- [Baikal](./services/baikal) - A CalDAV and CardDAV server
- [Vaultwarden](./services/vaultwarden) - A password manager
- [Steam-Headless](./services/steam-headless) - A headless Steam client for running games on a server you can access from your browser
- [ByteStash](./services/bytestash) - A small service to store code snippets and other text data
- [Scrutiny](./services/scrutiny) - A service to monitor the health of your hard drives
- [Utilities](./services/utilities)
  - [Stirling PDF](./services/stirling-pdf) - A collection of tools for working with PDFs
  - [ConvertX](./services/convertx) - A collection of tools for converting files
  - [Web-Check](./services/web-check) - A service to check the status of web services
  - [My-IP](./services/my-ip) - A service to check the IP of the client and related information
  - [IT-Tools](./services/it-tools) - A collection of tools for Developers and IT professionals
- [Networking](./services/networking/)
  - [Traefik](./services/traefik) - Container-focused Reverse Proxy
  - [Cloudflared](./services/cloudflared) - Cloudflare's Zero Trust tunnels
  - [Wireguard](./services/vpn) - VPN tunnel
  - [PiHole](./services/pihole) - Network-wide Adblocking and DNS Management
  - [MQTT](./services/mqtt) - MQTT Servers for Cross-Server Communication
    - RabbitMQ
    - Mosquitto
  - Authelia (part of stacks) - Reverse proxy forward auth middleware and SSO provider
- [Media](./media)
  - [ErsatzTV](./services/ersatztv) - A service to create a TV guide for your media
  - [Jellyfin](./services/jellyfin) - Media organization and viewing
    - Includes Jellyseerr
  - [Jellyfin Auto Collections](./services/jellyfin-auto-collections/) - Automatically create collections in Jellyfin based on configurable lists
  - [Wizarr](./services/wizarr) - User management and onboarding for Jellyfin
  - [Jellystat](./services/jellystat) - A page to get stats on your Jellyfin server usage
  - [Metube](./services/metube) - A service to assist in downloading youtube videos
  - [Pinchflat](./services/pinchflat) - A service to assist in downloading youtube videos, but more focused on continuous downloads playlists and channels (for archiving, collecting shows for Jellyfin, etc).
- [Databases](./databases)
  - [CloudBeaver](./services/databases/cloudbeaver) - A web-based database management tool
  - [SQLite-Browser](./services/databases/sqlite-browser) - A GUI for SQLite databases
  - [MySQL](./services/databases/mysql) - SQL based Database
  - [Postgres](./services/databases/postgres) - SQL based Database
- [Games](./games)
  - Factorio
  - Minecraft
  - Valheim
  - Terraria
  - Project Zomboid
  - The Forest
  - Skyrim Together Reborn
  - Palworld

## Stacks

These are more fully designed solutions rather than a service with a container or two.

- [Media Consumption](./stacks/media-consumption/) - A paired down media consumption stack
- [System Monitoring](./stacks/system-monitoring) - Exposes a Prometheus service pulling host machine and container stats

Core stacks that reflect my main service setups

- [Infrastructure](./stacks/core/infrastructure/) - Mostly services that support other services, like network infrastructure, databases, and media aquisition
- [Main](./stacks/core/main/) - Mostly daily driver services

## Notes

_Eventually, to simplify maintenance after playing with the cluster, I moved back to just hosting everything in Docker on my server or NAS based on the type of service it was (more critical stuff stayed on the NAS because it has data redundancy and it's less likely to get rebooted over the server)_

Setting up an app in Docker that is proxied by Traefik in the cluster (yes this is kind of a weird hybrid set up for a service but we are self-hosting stuff here) requires two steps.

1. Set up the Docker container on a host machine accessible by the cluster
2. Use the provided `nonHostedTraefikRoute.yaml` k3s deployment to create a service that routes traffic to the container

I use unRAID for my NAS OS and adjusted the web UI port to live on 55080 instead of 80 so Traefik could bind to and control port 80 on that machine

If your Ubuntu install doesn't take up your whole drive for whatever reason [try this](https://askubuntu.com/questions/1269493/ubuntu-server-20-04-1-lts-not-all-disk-space-was-allocated-during-installation)

_Eventually, I wanted to try Proxmox out...so I migrated all my Docker services to my NAS and turned the other server into a Proxmox host_
