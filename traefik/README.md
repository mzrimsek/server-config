# Traefik

[Traefik](https://doc.traefik.io/traefik/) is a microservice focused reverse proxy that allows routing network to Docker containers running various services. This stack creates the network that public traffic is routed through - any containers that need traffic routed to them must be on this network. Make sure to add DNS A entries to point subdomains at the correct IP address so Traefik can correctly route the traffic to each container as desired.

### Using Docker Compose

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_stack.sh` script to operate correctly.

### Using Kubernetes

Note: Will only work if the cluster doesn't have Traefik deployed in it already. Results in a 2.x install of Traefik deployed in the cluster.

1. Apply `customResourceDefinitions.yaml`
2. Replace `${EMAIL}` and `${PROXY_URL}` in `k3s.yaml`
3. Apply `k3s.yaml`