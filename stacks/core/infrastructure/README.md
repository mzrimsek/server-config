# Infrastructure

All the services deployed on the NAS in one stack. Services that live on the NAS are infrastructure related (databases, mqtt client, vpn) or are things that require direct file access (transmission, trilium) that I want on redundant storage. Only service not included is Portainer which is installed via unRaid's community apps (easier to get an interface to run the stack this way). Goal here is to have all the more background type stuff in one place on a server that is more likely to be up.

## Services

- Traefik - Container-first Reverse Proxy
- Pihole - Local DNS configuration and Network Adblocker
- NordVPN - VPN container for containers to communicate over
- Wireguard - (WORK IN PROGRESS)
- Postgres - SQL Database
- pgAdmin - Web interface for Postgres database access and management
- Transmission - Torrent download client
- Prowlarr - Torrent Indexer management
- Sonarr - TV torrent management
- Radarr - Movie torrent management
- Lidarr - Music torrent management
- Readarr - Ebook and Audiobook torrent management (WORK IN PROGRESS)
- Calibre - Ebook and Audiobook Library mangement and Ereader
- Calibre-web - Calibre web interface for downloading Ebooks and sharing to Kindle
- Trilium - Knowledge-base and note taking
- Mosquitto - Lightweight MQTT server

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable                 | Description                                                                                                                 |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR               | Root directory where service configuration files will live                                                                  |
| MEDIA_DIR                | Parent directory for tv, movie, etc. media libraries                                                                        |
| DOWNLOADS_DIR            | Parent directory for automated file downloads to be organized within                                                        |
| TIMEZONE                 | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| HOST_IP                  | IP address of machine hosting these containers                                                                              |
| PUID                     | User Id of the host user that containers should run under (for applicable containers)                                       |
| PGID                     | Group Id of the host user that containers should run under (for applicable containers)                                      |
| TRAEFIK_TLS_EMAIL        | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL    | Subdomain to route to the Traefik dashboard                                                                                 |
| TRAEFIK_DASHBOARD_USER   | [User credentials](https://doc.traefik.io/traefik/middlewares/http/basicauth/) to restrict access to Traefik dashboard      |
| NORDVPN_USER             | NordVPN account username / email                                                                                            |
| NORDVPN_PASS             | NordVPN account password                                                                                                    |
| PIHOLE_PASSWORD          | Password to access the PiHole admin dashboard                                                                               |
| PIHOLE_URL               | Subdomain to route to the PiHole admin dashboard                                                                            |
| POSTGRES_USER            | Name of admin user for database                                                                                             |
| POSTGRES_PASSWORD        | Password of admin user for database                                                                                         |
| PGADMIN_DEFAULT_EMAIL    | PgAdmin default user email                                                                                                  |
| PGADMIN_DEFAULT_PASSWORD | PgAdmin default user password                                                                                               |
| PGADMIN_URL              | Subdomain to route to PgAdmin database management dashboard                                                                 |
| TRILIUM_URL              | Subdomain to route to Trilium knowledge-base                                                                                |
| PROWLARR_URL             | Subdomain to route to torrent indexer management interface                                                                  |
| SONARR_URL               | Subdomain to route to tv show torrent management interface                                                                  |
| RADARR_URL               | Subdomain to route to movie torrent management interface                                                                    |
| LIDARR_URL               | Subdomain to route to music torrent management interface                                                                    |
| READARR_URL              | Subdomain to route to book and audiobook torrent management interface                                                       |
| CALIBRE_LIBRARY_URL      | Subdomain to route to Calibre desktop application management interface                                                      |
| CALIBRE_READER_URL       | Subdomain to route to Calibre web Ereader                                                                                   |
| CALIBRE_WEB_URL          | Subdomain to route to Calibre web management interface                                                                      |
| TRANSMISSION_USERNAME    | Transmission client admin user username                                                                                     |
| TRANSMISSION_PASSWORD    | Transmission client admin user password                                                                                     |
| TRANSMISSION_URL         | Subdomain to route to download client web interface                                                                         |

### File Structure

- MEDIA_DIR subdirectories need to be manually created
- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /media (MEDIA_DIR)
    /tv
    /movies
    /music
    /books
      /uploads
      /library
    /downloads (DOWNLOADS_DIR)
      /complete
      /pending
  /config (CONFIG_DIR)
    /traefik
      /providers
      /certs
    /pihole
      /etc
      /dnsmasq.d
    /postgres
      /db_data
      /pgadmin_data
      /backup
    /trilium
    /prowlarr
    /sonarr
    /radarr
    /lidarr
    /readarr
    /calibre
    /calibre-web
    /transmission
    /mosquitto
      /data
      /log
      /config
```

### Notes

- Subdomains are assumed to be public. Traefik TLS for local subdomains is WORK IN PROGRESS
- VPN container also supports other VPN providers if they are more preferable. See [wiki](https://github.com/qdm12/gluetun/wiki) for more info
- When setting up the services running through the VPN, for container-to-container communication treats them as all running on the same network. All services should be available to each other on localhost with their respective ports.
- For the torrent management services I also configured them locally before exposing them. Link all the services together and set up form authentication first thing to make sure nothing sensitive is unprotected.
- PUID and PGID must be the user that has control over the media files. I chown'd the whole file tree to make sure that user would have all the permissions it needed, thus giving the containers that do the media file manipulation all the permissions they would need as well.
