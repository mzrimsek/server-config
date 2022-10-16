# Networking

A basic stack of networking focused services

## Services

- Traefik - Container-first Reverse Proxy
- NordVPN - VPN container for containers to communicate over
- PiHole - Local DNS configuration and Network Adblocker
- Wireguard (WORK IN PROGRESS)

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable               | Description                                                                                                                 |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR             | Root directory where service configuration files will live                                                                  |
| TIMEZONE               | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| HOST_IP                | IP address of machine hosting these containers                                                                              |
| PUID                   | User Id of the host user that containers should run under (for applicable containers)                                       |
| PGID                   | Group Id of the host user that containers should run under (for applicable containers)                                      |
| TRAEFIK_TLS_EMAIL      | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL  | Subdomain to route to the Traefik dashboard                                                                                 |
| TRAEFIK_DASHBOARD_USER | [User credentials](https://doc.traefik.io/traefik/middlewares/http/basicauth/) to restrict access to Traefik dashboard      |
| NORDVPN_USER           | NordVPN account username / email                                                                                            |
| NORDVPN_PASS           | NordVPN account password                                                                                                    |
| PIHOLE_PASSWORD        | Password to access the PiHole admin dashboard                                                                               |
| PIHOLE_URL             | Subdomain to route to the PiHole admin dashboard                                                                            |

### File Structure

- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /traefik
      /providers
      /certs
    /pihole
      /etc
      /dnsmasq.d
    /wireguard
      /periodic
      /config
      /bird
```

## Configuration

### Wireguard

TBD
