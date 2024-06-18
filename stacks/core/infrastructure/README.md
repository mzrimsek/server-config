# Infrastructure

All the services deployed on the NAS in one stack. Services that live on the NAS are infrastructure related (databases, mqtt client, vpn) or are things that require direct file access (transmission, trilium) that I want on redundant storage. Only service not included is Portainer which is installed via unRaid's community apps (easier to get an interface to run the stack this way). Goal here is to have all the more background type stuff in one place on a server that is more likely to be up.

## Services

- Traefik - Container-first Reverse Proxy
- Pihole - Local DNS configuration and Network Adblocker
- Gluetun - VPN container for containers to communicate over
- Postgres - SQL Database
- pgAdmin - Web interface for Postgres database access and management
- Transmission - Torrent download client
- Prowlarr - Torrent Indexer management
- Sonarr - TV torrent management
- Radarr - Movie torrent management
- Lidarr - Music torrent management
- Readarr - Ebook and Audiobook torrent management
- Mylar3 - Comic torrent management
- Bazarr - Subtitle Management
- Jellyseerr - Streamlines requests to Sonarr and Radarr for a Jellyfin library
- Trilium - Knowledge-base and note taking
- Mosquitto - Lightweight MQTT server
- Duplicati - Remote file backup
- OpenLDAP - Open source LDAP server for centralized user & group management
- phpLDAPadmin - Powerful interface to manage LDAP servers
- Authelia - SSO OAuth provider to centralize authenication to services
- Wireguard - Easily configurable VPN tunnel access

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
| MAILER_HOST              | SMTP server host                                                                                                            |
| MAILER_PORT              | SMTP server port                                                                                                            |
| MAILER_USERNAME          | SMTP server username                                                                                                        |
| MAILER_PASSWORD          | SMTP server password                                                                                                        |
| TRAEFIK_TLS_EMAIL        | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL    | Subdomain to route to the Traefik dashboard                                                                                 |
| TRAEFIK_DASHBOARD_USER   | [User credentials](https://doc.traefik.io/traefik/middlewares/http/basicauth/) to restrict access to Traefik dashboard      |
| VPN_PROVIDER             | VPN service Gluetun should use                                                                                              |
| VPN_USER                 | VPN service credentials username / email                                                                                    |
| VPN_PASS                 | VPN service credentials password                                                                                            |
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
| TRANSMISSION_USERNAME    | Transmission client admin user username                                                                                     |
| TRANSMISSION_PASSWORD    | Transmission client admin user password                                                                                     |
| TRANSMISSION_URL         | Subdomain to route to download client web interface                                                                         |
| APP_THEME                | [Addon themes](https://theme-park.dev/) for the media aquisition services (`organizr` is a great dark theme)                |
| BACKUP_ROOT              | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |
| LDAP_ORGANIZATION        | Name of your LDAP organization                                                                                              |
| LDAP_DOMAIN              | If your domain is "google.com", just put "google"                                                                           |
| LDAP_TLD                 | If your domain is "google.com", just put "com"                                                                              |
| LDAP_ADMIN_PASSWORD      | Password for admin account                                                                                                  |
| LDAP_CONFIG_PASSWORD     | LDAP Server Configuration Password                                                                                          |
| LDAP_UI_URL              | Subdomain to route to user management dashboard                                                                             |
| AUTHELIA_URL             | Subdomain to route to Authelia login page                                                                                   |
| WIREGUARD_ADMIN_PASSWORD | Admin user password                                                                                                         |
| WIREGUARD_URL            | Subdomain to route to the Wireguard login page                                                                              |
| WIREGUARD_PRIVATE_KEY    | Generate with `wg generate`. If you change it every device has to be reconfigured                                           |
| DATABASE_HOST            | Database connection host machine                                                                                            |
| DATABASE_USER            | Database connection username                                                                                                |
| DATABASE_PASSWORD        | Database connection password                                                                                                |
| BAZARR_URL               | Subdomain to route to subtitle management interface                                                                         |
| MYLAR3_URL               | Subdomain to route to comic management interface                                                                            |
| JELLYSEERR_URL           | Subdomain to route to the Jellyseerr media request interface                                                                |
| DUPLICATI_PUID           | User Id that the Duplicati container should run under.                                                                      |
| DUPLICATI_PGID           | Group Id that the Duplicati container should run under.                                                                     |

#### Authelia

The Authelia config file is templated with variables to replace. Some of them are duplicates of the above.

More access control rules can be found [here](https://www.authelia.com/configuration/security/access-control/#access-control-list).

More OpenID Connect client configuration options can be found [here](https://www.authelia.com/configuration/identity-providers/open-id-connect/#clients)

| Variable                        | Description                                                                                                                                              |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AUTHELIA_JWT_SECRET             | 64+ character secret used for JWT generation                                                                                                             |
| AUTHELIA_SESSION_SECRET         | Secret used for session management                                                                                                                       |
| AUTHELIA_OAUTH_SECRET           | 64+ character secret used to sign JWTs                                                                                                                   |
| AUTHELIA_DEFAULT_REDIRECT       | Default redirect route after logging in                                                                                                                  |
| AUTHELIA_STORAGE_ENCRYPTION_KEY | Secret used to encrypt infomation in the database                                                                                                        |
| AUTHELIA_OAUTH_PRIVATE_KEY      | [Generated](https://www.authelia.com/reference/guides/generating-secure-values/#generating-an-rsa-keypair) RSA Private key to validate requests against. |
| LDAP_DOMAIN                     | If your domain is "google.com", just put "google"                                                                                                        |
| LDAP_TLD                        | If your domain is "google.com", just put "com"                                                                                                           |
| LDAP_ADMIN_PASSWORD             | Password for admin account                                                                                                                               |
| DATABASE_HOST                   | Database connection host machine                                                                                                                         |
| DATABASE_USER                   | Database connection username                                                                                                                             |
| DATABASE_PASSWORD               | Database connection password                                                                                                                             |
| MAILER_HOST                     | SMTP server host                                                                                                                                         |
| MAILER_PORT                     | SMTP server port                                                                                                                                         |
| MAILER_USERNAME                 | SMTP server username                                                                                                                                     |
| MAILER_PASSWORD                 | SMTP server password                                                                                                                                     |

##### Redis Notes

I was having intermittent issues with the Redis container being unable to write to the db file and being unable to generate temp files when saving data. It seems that the redis container will chown the mounted volume as root and then step down the redis user, causing permission issues in some systems.

I added a `fix-redis.sh` script that will step into the container and chown some volumes that may be the culprits as the redis user to ensure the redis-server process in the container has the permissions it needs to write to the mounted volumes. Not a perfect fix but should work for now. Will probably revisit at a later time to try and make it happen automatically rather than as a separate script.

#### Wireguard

The Wireguard configuration file provided sets up an OIDC login provider - here it's being used to point towards Authelia to use as an identity provider

| Variable                | Description                                       |
| ----------------------- | ------------------------------------------------- |
| AUTHELIA_URL            | Subdomain to route to Authelia login page         |
| WIREGUARD_URL           | Subdomain to route to Wireguard login page        |
| WIREGUARD_CLIENT_SECRET | Configured OIDC                                   |
| LDAP_DOMAIN             | If your domain is "google.com", just put "google" |
| LDAP_TLD                | If your domain is "google.com", just put "com"    |

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
    /comics
    /downloads (DOWNLOADS_DIR)
      /complete
      /pending
  /config (CONFIG_DIR)
    /authelia
      /redis
      /configuration.yaml
    /bazarr
    /duplicati
    /lidarr
    /jellyseerr
    /mosquitto
      /data
      /log
      /config
    /openldap
      /etc_ldap_slapd.d
      /ui
      /var_lib_ldap
    /pihole
      /etc
      /dnsmasq.d
    /postgres
      /db_data
      /pgadmin_data
      /backup
    /prowlarr
    /radarr
    /readarr
    /sonarr
    /mylar3
    /traefik
      /providers
      /certs
    /transmission
    /trilium
    /wireguard
      /config.yaml
      /data
```

## Additional Configurations

### Traefik Prometheus Exports

Add this to your Prometheus configuration to scrape Traefik data

```yml
- job_name: 'traefik'
    scrape_interval: 5s
    static_configs:
      - targets: ['${HOST_IP}:8082']
```

### Authelia Prometheus Exports

Add this to your Prometheus configuration to scrap Authelia data

```yml
- job_name: 'authelia'
    scrape_interval: 5s
    static_configs:
      - targets: ['${HOST_IP}:9959']
```

## Notes

- Subdomains are assumed to be public. Traefik TLS for local subdomains is WORK IN PROGRESS
- VPN container also supports other VPN providers if they are more preferable. See [wiki](https://github.com/qdm12/gluetun/wiki) for more info
- When setting up the services running through the VPN, for container-to-container communication treats them as all running on the same network. All services should be available to each other on localhost with their respective ports.
- For the torrent management services I also configured them locally before exposing them. Link all the services together and set up form authentication first thing to make sure nothing sensitive is unprotected. _I have since removed the auth in the apps in favor of Authelia middleware_
- PUID and PGID must be the user that has control over the media files. I chown'd the whole file tree to make sure that user would have all the permissions it needed, thus giving the containers that do the media file manipulation all the permissions they would need as well.
- Duplicati is being used for backing up some files to Google Drive. Duplicati can't interact to create files at it's destination when not running in Host mode for some reason. [See here](https://forum.duplicati.com/t/google-drive-shared-drive-path-error/14036/3)
- Make sure to rename the Authelia config file to "configuration.yml" if copying to the volume
- Make sure to rename the Wireguard config file to "config.yaml" if copying to the volume. If you need the config file, it needs to be in the directory that will be mounted BEFORE you run the container, otherwise it will create and mount a directory with the filename. [It's stupid](https://stackoverflow.com/a/42260979).
- Bazarr doesn't really need to live in the VPN network but it does need direct access to the Sonarr and Radarr services, so adding it to the VPN services seems like the easiest way to accomplish that
- Jellyseerr lives in this stack for the same reason as Bazarr - it integrates closely with services already in the VPN network. You could argue it goes with the Jellyfin stack as well.\
- A recent change to Prowlarr forces you to set up authentication for the application which is not always a desirable based on your configuration, like if you have Authelia protecting your routes already. You can no longer disable auth from the web, but [it is still configurable from the config file](https://wiki.servarr.com/prowlarr/faq#can-i-disable-forced-authentication).
- Increased the Authelia buffer sizes because some services (Firefly III) will have massive requests that get rejected
- Added duplicati specific user and group id variables to help with some permission issues
- When you spin up the radarr-audiobooks instance you need to go into the config file it generates and modify the port from 8787 to 8788
