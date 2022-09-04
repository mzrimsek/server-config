# Route Local Services

Say you want to have a service that is only available on your local network like `portainer.local` so you can have an easy url while not exposing the service outside your network.

Using Traefik and Pihole, I mapped the ports on the service so it's accessbile in the network, then added a [Traefik file provider config for that service](../traefik/file_provider.yaml) which specified the local subdomain I would like and points it at our service. The final step was going in Pihole and added a local DNS entry with the matching local subdomain.