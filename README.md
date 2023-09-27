# server-config

A repo of files to set up my local server running [Ubuntu 20.04 Server](https://ubuntu.com/server/docs/installation).

To achieve a similar set up you must have [Docker](https://docs.docker.com/get-docker/) installed, with Docker Compose recommended. Script included here but it may not run all the way through - each command run separately should do the trick though. Hopefully this will be improved in the future. As an aside, installations on Raspberry Pis seem to be hit or miss, especially with older models - [this article](https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there's%20plenty%20of,can%20also%20install%20Docker%20Compose.) got Docker up and running on an older Pi that was a little more resistant installing with the commands in the included script.

[Portainer](https://www.portainer.io/) is highly recommended as an easy-to-use interface to manage your containers. By and large, each `docker-compose.yml` is deployed as a stack to take advantage of environment variable substitution and to allow control of the configurations through the Portainer interface.

After getting Portainer running, getting Traefik running next is probably the most sensible route to go. Optionally, allowing ssh access makes orchestrating this all remotely much easier. Many of the included `docker-compose.yml` files assume the networking stack is set up and have additional configurations with that mind.

As a side note, many of these setups also include Kubernetes configurations. If that is of interest, there is a corresponding folder that details how a cluster can be created. Due to Portainer's ability to manage Kubernetes clusters, it's likely still useful to have Portainer up and running, if only to add the cluster as an agent endpoint.

## Services

- [Portainer](./services/portainer) - Docker Container and Kubernetes Cluster Management and Orchestration
- [Traefik](./services/traefik) - Container-focused Reverse Proxy
- [Jenkins](./services/jenkins) - Customizable Build Server
- [Postgres](./services/postgres) - SQL based Database
- [MQTT](./services/mqtt) - MQTT Servers for Cross-Server Communication
  - RabbitMQ
  - Mosquitto
- [Home Assistant](./services/homeassistant) - Home Automation Platform
- [Homepage](./services/homepage) - Simple and Customizable Dashboard for your Services
- [Vikunja](./services/vikunja) - Task Management Platform
- [Trilium](./services/trilium) - OneNote-like Wiki and Notes Platform
- [Firefly III](./services/fireflyiii) - Budgeting and Transaction Tracking
- [Muse](./services/muse) - A Discord music bot
- [n8n](./services/n8n) - An automation platform similar to
- [PiHole](./services/pihole) - Network-wide Adblocking and DNS Management
- [Jellyfin](./services/jellyfin) - Media organization and viewing
  - Includes Jellyseerr
- [Transmission](./services/torrent) - Torrenting download client
- [Duplicati](./services/duplicati/) - File backup
- [OpenLDAP](./services/ldap) - User credential backend
- [Wireguard](./services/vpn) - VPN tunnel
- Authelia (part of stacks) - Reverse proxy forward auth middleware and SSO provider
- [Grafana](./services/grafana/) - Data visualization
- [Speedtest Tracker](./services/speedtest/) - Continuous Network Speedtests
- [Uptime Kama](./services/uptime/) - Continuous uptime monitoring for websites, ports, and various other services
- [KASM Workspaces](./services/kasm) - Container Streaming Platform
- [Grocy](./services/grocy) - Groceries and household management
- [Ntfy](./services/ntfy) - Simple notification service
- [Games](./games)
  - Factorio
  - Minecraft
  - Valheim
  - Terraria
  - Project Zomboid
  - The Forest
  - Skyrim Together Reborn

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
