# Traefik

[Traefik](https://doc.traefik.io/traefik/) is a microservice focused reverse proxy that allows routing network to Docker containers running various services. This stack creates the network that public traffic is routed through - any containers that need traffic routed to them must be on this network. Make sure to add DNS A entries to point subdomains at the correct IP address so Traefik can correctly route the traffic to each container as desired.

### Using Docker Compose

- Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_stack.sh` script to operate correctly.
- Copy dynamic_conf.yaml` to your directory that will be mounted at `/config` on the container

### Using Kubernetes

Note: Will only work if the cluster doesn't have Traefik deployed in it already. Results in a 2.x install of Traefik deployed in the cluster.

1. Apply `customResourceDefinitions.yaml`
2. Replace `${EMAIL}` and `${PROXY_URL}` in `k3s.yaml`
3. Apply `k3s.yaml`

### Routing to External Services

Many of the services have docker-compose files that have labels to hook into Traefik's routing, but this only works for containers that live on the same host as the container that is running the Traefik service. For multi-host setups (in my case a server and NAS), the file provider allows us to hook into Traefik and give it the URL of the service running on the other host.

To configure use of the file provider, ensure the `- "--providers.file.directory=/config"` label is on the Traefik container (configured with docker-compose). Then make sure to map a volume to the `/config` directory. Finally place your file provider configurations in this directory.

The `file_provider.yaml` is a simple example to get a routing working with TLS for external services. It seems to configure routing in the same manner that the labels used would.

1. Replace all instances of `${SERVICE_NAME}` with the name of the service you want to route to (e.g. portainer)
2. Replace the `${TRAEFIK_PROXY_URL}` with the desired url to route to the service (this should be identical to how configuring the docker-compose file works)
3. Replace the `${SERVICE_URL}` with url of the service on the other host (e.g. http://host2:8080)

Making a separate small file for each service seems like the clean way to do this, but it's not required and you very well could configure all of your external services in one file provider configuration.