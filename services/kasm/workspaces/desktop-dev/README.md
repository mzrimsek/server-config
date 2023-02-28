# KASM workspaces

A container streaming service to spin up services on demand in the browser

## Install

I'm not doing anything highly distributed so I went with the [Single Server Install](https://kasmweb.com/docs/latest/install/single_server_install.html).

I install mine on port 8443 to avoid conflicting with other services.

### Configure Traefik

You'll need to modify the KASM Docker Compose file found at `/opt/kasm/{VERSION}/docker`.

Make the following changes to the docker compose file

```yml
# ...rest of the file
  proxy:
    container_name: kasm_proxy
    image: "kasmweb/nginx:latest"
    #ports:
    #  - "8443:8443"
    expose:
      - 8443
    networks:
      - kasm_default_network
    volumes:
    # ...keep skipping down through this service
    logging:
    # ...keep going
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.kasm.rule=Host(`${KASM_URL}`)"
      - "traefik.http.routers.kasm.entrypoints=websecure"
      - "traefik.http.routers.kasm.tls.certresolver=tlsresolver"
      - "traefik.http.services.kasm.loadbalancer.server.port=8443"
      - "traefik.http.services.kasm.loadbalancer.server.scheme=https"
# ...
networks:
  kasm_default_network:
    external:
      name: ${TRAEFIK_NETWORK_NAME}
```

Remove all containers from the existing `kasm_default_network` and then delete the network. Effectively we want to replace the created network with the one we already have.

Stop the containers `sudo /opt/kasm/bin/stop` and then delete them.

Then restart kasm with `sudo /opt/kasm/bin/start` to recreate everything.

## Uninstall

Uninstalling is [pretty painless honestly](https://kasmweb.com/docs/latest/install/uninstall.html)
