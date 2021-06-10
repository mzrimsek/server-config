# Portainer

A fantastic interface for managing docker containers. For setting up, I feel it makes the most sense to utilize docker-compose outside of Portainer itself, unlike the other setups...otherwise you're using Portainer to set up Portainer which just feels weird. It may make sense to exclude the labels from the Portainer container for initial setup, as the setup included assumes Traefik has been configured. If there are multiple devices running Docker on your network, it may make sense to manage them all from the same Portainer instance. [Exposing the Docker daemons](https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248) on the devices not running Portainer will allow them to be added as endpoints alongside the local Docker instance.

* Data: Must have a directory to persist data, mounted as a volume to `/data`

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_portainer.sh` script to operate correctly.