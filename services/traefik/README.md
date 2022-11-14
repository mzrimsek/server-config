# Traefik

[Traefik](https://doc.traefik.io/traefik/) is a microservice focused reverse proxy that allows routing network to Docker containers running various services. This stack creates the network that public traffic is routed through - any containers that need traffic routed to them must be on this network. Make sure to add DNS A entries to point subdomains at the correct IP address so Traefik can correctly route the traffic to each container as desired.

### Using Docker Compose

- Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_stack.sh` script to operate correctly.

### Using Kubernetes

Note: Will only work if the cluster doesn't have Traefik deployed in it already. Results in a 2.x install of Traefik deployed in the cluster.

1. Apply `customResourceDefinitions.yaml`
2. Replace `${EMAIL}` and `${PROXY_URL}` in `k3s.yaml`
3. Apply `k3s.yaml`

### Routing to External Services

Many of the services have docker-compose files that have labels to hook into Traefik's routing, but this only works for containers that live on the same host as the container that is running the Traefik service. For multi-host setups (in my case a server and NAS), the file provider allows us to hook into Traefik and give it the URL of the service running on the other host.

To configure use of the file provider, ensure the `- "--providers.file.directory=/config"` label is on the Traefik container (configured with docker-compose). Then make sure to map a volume to the `/config` directory. Finally place your file provider configurations in this directory.

The `external_https_file_provider.yaml` is a simple example to get a routing working with TLS for external services. It seems to configure routing in the same manner that the labels used would.

1. Replace all instances of `${SERVICE_NAME}` with the name of the service you want to route to (e.g. portainer)
2. Replace the `${TRAEFIK_PROXY_URL}` with the desired url to route to the service (this should be identical to how configuring the docker-compose file works)
3. Replace the `${SERVICE_URL}` with url of the service on the other host (e.g. http://host2:8080)

Making a separate small file for each service seems like the clean way to do this, but it's not required and you very well could configure all of your external services in one file provider configuration.

#### Routing to Internal Services

The process is essentially the same as using the external provider, except you need to set up some certs that are valid for local routing. The steps to set everything up are as follows:

1. Run `mkcert -install && mkcert -cert-file ${HOST_CERTS_DIR}/local-cert.pem -key-file ${HOST_CERTS_DIR}/local-key.pem "docker.localhost" "*.docker.localhost" "${DOMAIN}.local" "*.${DOMAIN}.local"`
2. Copy these files to the directory that will be mounted to your container at `/etc/certs`
3. Copy the `default_conf.yaml` to the directory that will be mounted to your container at `/config`

Now you can use the `local_https_file_provider.yaml` example to add providers to route traffic. Replacing variables works basically the same as external provider instructions.

The only other caveat with the local routing is you need some DNS entry that will route these subdomains back to your Traefik instance. For my purposes, I am using a Pihole container with local DNS entries to route each local address I've added.