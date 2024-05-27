# paperless-ngx

A PDF processing and management server

## Notes on Deployment

For whatever reason I was having intermittent issues with gateway timeouts using the Traefik labels on my paperless service. I ended up doing a [traefik file provider](../traefik/external_https_file_provider.yaml) to get it to work.
