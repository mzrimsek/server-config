# server-config

A repo of files to set up my local server running [Ubuntu 20.04 Server](https://ubuntu.com/server/docs/installation).

To achieve a similar set up you must have [Docker](https://docs.docker.com/get-docker/) installed, with Docker Compose recommended. Script included here but it may not run all the way through - each command run separately should do the trick though. Hopefully this will be improved in the future.

[Portainer](https://www.portainer.io/) is highly recommended as an easy-to-use interface to manage your containers. By and large, each ```docker-compose.yml``` is deployed as a stack to take advantage of environment variable substitution.

After getting Portainer running, getting the networking stack running next is probably the most sensible route to go. Script included.

Optionally, allowing ssh access makes orchestrating this all remotely much easier. Script included.

## Networking

Set up [Traefik](https://doc.traefik.io/traefik/) to reverse proxy traffic to Docker containers running various services. This stack creates the network that public traffic is routed through - any containers that need traffic routed to them must be on this network.

* Configuration: Mount the ```traefik.yml``` file as a volume to ```/traefik.yml```. Organizing these configuration files into a folder is recommended but not necessary.

* TLS: Must have a directory to host Let's Encrypt certificate information, mounted as a volume to ```/letsencrypt```. In the ```traefik.yml``` file, ```acme.json``` is specified as the file to be created in this directory to contain all certification information.

## Home Assistant

Set up a local [Home Assistant](https://www.home-assistant.io/) instance to control smart devices on the network.

* Configuration: Must have a directory to persist integration and device configuration, mounted as a volume to ```/config```

## Games

Set up various game servers.

### Factorio

* Server Data: Must have a directory to persist server data, mounted as a volume to ```/factorio```

### Minecraft

This setup allows for potentially running several Minecraft server instances (each with their own volumes and such required), each with their proxy url. This also allows for a cleaner routing to servers due to the port no longer being required when connecting in the game client.

* World Data: Must have a directory to persist world data, mounted as a volume to ```/data```

* Modpacks: Must have a directory containing the desired modpack as a zip, mounted as a volume to ```/modpacks```