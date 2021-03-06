# server-config

A repo of files to set up my local server running [Ubuntu 20.04 Server](https://ubuntu.com/server/docs/installation).

To achieve a similar set up you must have [Docker](https://docs.docker.com/get-docker/) installed, with Docker Compose recommended. Script included here but it may not run all the way through - each command run separately should do the trick though. Hopefully this will be improved in the future. As an aside, installations on Raspberry Pis seem to be hit or miss, especially with older models - [this article](https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there's%20plenty%20of,can%20also%20install%20Docker%20Compose.) got Docker up and running on an older Pi that was a little more resistant installing with the commands in the included script.

[Portainer](https://www.portainer.io/) is highly recommended as an easy-to-use interface to manage your containers. By and large, each `docker-compose.yml` is deployed as a stack to take advantage of environment variable substitution and to allow control of the configurations through the Portainer interface.

After getting Portainer running, getting Traefik running next is probably the most sensible route to go. Optionally, allowing ssh access makes orchestrating this all remotely much easier. Many of the included `docker-compose.yml` files assume the networking stack is set up and have additional configurations with that mind. If the networking stack won't be used, there are also alternative `noproxy.docker-compose.yml` files included that don't have the extra configuration.

As a side note, many of these setups also include Kubernetes configurations. If that is of interest, there is a corresponding folder that details how a cluster can be created. Due to Portainer's ability to manage Kubernetes clusters, it's likely still useful to have Portainer up and running, if only to add the cluster as an agent endpoint.

## Stacks

- [Portainer](./portainer)
- [Traefik](./traefik)
- [Jenkins](./jenkins)
- [Postgres](./postgres)
- [MQTT](./mqtt)
  - RabbitMQ
  - Mosquitto
- [Monitoring](./monitor)
- [Home Assistant](./homeassistant)
- [Dashboard](./dashboard)
- [Games](./games)
  - Factorio
  - Minecraft
  - Valheim
  - Terraria
