# server-config

A repo of files to set up my local server running [Ubuntu 20.04 Server](https://ubuntu.com/server/docs/installation).

To achieve a similar set up you must have [Docker](https://docs.docker.com/get-docker/) installed, with Docker Compose recommended. Script included here but it may not run all the way through - each command run separately should do the trick though. Hopefully this will be improved in the future. As an aside, installations on Raspberry Pis seem to be hit or miss, especially with older models - [this article](https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there's%20plenty%20of,can%20also%20install%20Docker%20Compose.) got Docker up and running on an older Pi that was a little more resistant installing with the commands in the included script.

[Portainer](https://www.portainer.io/) is highly recommended as an easy-to-use interface to manage your containers. By and large, each `docker-compose.yml` is deployed as a stack to take advantage of environment variable substitution and to allow control of the configurations through the Portainer interface. 

After getting Portainer running, getting Traefik running next is probably the most sensible route to go. Optionally, allowing ssh access makes orchestrating this all remotely much easier. Many of the included `docker-compose.yml` files assume the networking stack is set up and have additional configurations with that mind. If the networking stack won't be used, there are also alternative `noproxy.docker-compose.yml` files included that don't have the extra configuration.

As a side note, many of these setups also include Kubernetes configurations. If that is of interest, there is a corresponding folder that details how a cluster can be created. Due to Portainer's ability to manage Kubernetes clusters, it's likely still useful to have Portainer up and running, if only to add the cluster as an agent endpoint.

## Portainer

A fantastic interface for managing docker containers. For setting up, I feel it makes the most sense to utilize docker-compose outside of Portainer itself, unlike the other setups...otherwise you're using Portainer to set up Portainer which just feels weird. It may make sense to exclude the labels from the Portainer container for initial setup, as the setup included assumes Traefik has been configured. If there are multiple devices running Docker on your network, it may make sense to manage them all from the same Portainer instance. [Exposing the Docker daemons](https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248) on the devices not running Portainer will allow them to be added as endpoints alongside the local Docker instance.

* Data: Must have a directory to persist data, mounted as a volume to `/data`

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_portainer.sh` script to operate correctly.

## Traefik

[Traefik](https://doc.traefik.io/traefik/) is a microservice focused reverse proxy that allows routing network to Docker containers running various services. This stack creates the network that public traffic is routed through - any containers that need traffic routed to them must be on this network. Make sure to add DNS A entries to point subdomains at the correct IP address so Traefik can correctly route the traffic to each container as desired.

### Using Docker Compose

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_stack.sh` script to operate correctly.

### Using Kubernetes

Note: Will only work if the cluster doesn't have Traefik deployed in it already. Results in a 2.x install of Traefik deployed in the cluster.

1. Apply `customResourceDefinitions.yaml`
2. Replace `${EMAIL}` and `${PROXY_URL}` in `k3s.yaml`
3. Apply `k3s.yaml`

## Jenkins

A great tool for building pipelines. This setup differs from the others in that it has a local Dockerfile to build the image on the host rather than pulling from a registry. This is to facilitate not only allowing Jenkins to run Docker commands, but also to give it the permissions it needs to allow that to happen. 

Essentially to allow Jenkins to use Docker or Docker Compose commands in pipelines, the container needs those installed. Then the user that Jenkins runs under also needs to be made part of the `docker` group, then those ids need to be passed into the Dockerfile when building the image so the container uses the same user and group as the host machine.

[Reference](https://itnext.io/docker-inside-docker-for-jenkins-d906b7b5f527)

Steps to prep `jenkins` user (all commands run on host machine):

1. Create user: `sudo useradd jenkins`
2. Add user to docker group: `sudo usermod -aG docker jenkins`
3. Restart docker service: `sudo service docker restart`

* Data: Must have a directory to persist data, mounted as a volume to `/var/jenkins_home`
  * The `jenkins` user must have permissions to this volume - `sudo chown -R $(id -u jenkins)`

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_.jenkins` script to operate correctly.
  * Grab the host jenkins user id: `id -u jenkins`
  * Grab the host docker group id: `getent group | grep docker`

## Postgres

[Postgres](https://www.postgresql.org/docs/13/index.html) is a great open source SQL database solution. [pgAdmin](https://www.pgadmin.org/) is a great open source database dashboard that allows administration and monitoring of databases.

* DB Data: Must have a directory to persist the database information, mounted as a volume to `/var/lib/postgresql/data` in the Postgres container
* Admin Data: Must have a directory to persist the admin panel information, mounted as a volume to `/var/lib/pgadmin` in the pgAdmin container

## MQTT Options

MQTT Brokers are great for asynchronously communicating data between applications without tightly coupling them to each other.

### RabbitMQ

[RabbitMQ](https://www.rabbitmq.com/) is a widely used MQTT broker.

* Data: Must have a directory to persist the message data, mounted as a volume to `var/lib/rabbitmq`
* Log: Must have a directory to persist the log information, mounted as a volume to `var/log/rabbitmq`

Note: RabbitMQ apparently does not work with Home Assistant - prefer using Mosquitto if that is a use case for the MQTT Broker.

### Mosquitto

Mosquitto is a super lightweight MQTT broker. [Info on setup](https://blog.feabhas.com/2020/02/running-the-eclipse-mosquitto-mqtt-broker-in-a-docker-container/).

* Data: Must have a directory to persist data, mounted as a volume to `/mosquitto/data`
* Log: Must have a directory to persist log files, mounted as a volume to `/mosquitto/log`
* Config: Must have a directory to persist config files, mounted as a volume to `/mosquitto/config`
  * Place the config file provided in this directory to get started

## Monitor

A great stack of services to enable seeing stats on the Docker host, as well as the containers running on it. Adapted from https://github.com/stefanprodan/dockprom.

The necessary files for each dashboard have been included.

## Home Assistant

Set up a local [Home Assistant](https://www.home-assistant.io/) instance to control smart devices on the network.

* Configuration: Must have a directory to persist integration and device configuration, mounted as a volume to `/config`

## Dashboard

Set up a nice dashboard with [Homer](https://github.com/bastienwirtz/homer) to access hosted services and frequently accessed sites all in a convenient, centralized location.

* Customization:
  * Must have a directory to persist assets, mounted as a volume to `/www/assets`
  * For ease of use, mount your `config.yml` to `/www/assets/config.yml`

## Games

Set up various game servers.

### Factorio

* Server Data: Must have a directory to persist server data, mounted as a volume to `/factorio`

### Minecraft

This setup allows for potentially running several Minecraft server instances (each with their own volumes and such required), each with their proxy url. This also allows for a cleaner routing to servers due to the port no longer being required when connecting in the game client.

* World Data: Must have a directory to persist world data, mounted as a volume to `/data`

* Modpacks: Must have a directory containing the desired modpack as a zip, mounted as a volume to `/modpacks`

### Valheim

* Config: Must have a directory to persist server config, mounted as a volume to `/config`

* World Data: Must have a directory to persist world data, mounted as volume to `/opt/valheim`

### Terraria

* Config: Must have a directory to persist server config, mounted as a volume to `/config`
  * If using the same image, follow the instructions on the [DockerHub](https://hub.docker.com/r/beardedio/terraria) page to create the world prior to starting the container.
    * `sudo docker run --rm -it -v $HOME/terraria/config:/config --name=terraria_temp beardedio/terraria`
  * Directory should have the world file, banlist file, and serverconfig file
  * Update `serverconfig.txt` to set the password if desired - uncomment the line and update with your password
