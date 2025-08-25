# Infrastructure

Core infrastructure services stack containing the foundational networking, authentication, and database services. This stack has been streamlined to focus on essential infrastructure components, with media and other application services moved to separate stacks for better modularity and maintenance.

## Services

- **Traefik** - Container-first Reverse Proxy with automatic SSL/TLS certificate management
- **Postgres** - SQL Database (PostgreSQL 16) with optimized connection settings
- **OpenLDAP** - Open source LDAP server for centralized user & group management
- **phpLDAPadmin** - Web interface to manage LDAP servers and users
- **Authelia** - SSO OAuth provider with forward authentication for service protection
- **Redis** - In-memory data store for Authelia session management
- **Mosquitto** - Lightweight MQTT message broker
- **Wireguard** - VPN access server with OIDC authentication integration

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable                 | Description                                                                                                                 |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR               | Root directory where service configuration files will live                                                                  |
| TIMEZONE                 | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| HOST_IP                  | IP address of machine hosting these containers                                                                              |
| MAILER_HOST              | SMTP server host                                                                                                            |
| MAILER_PORT              | SMTP server port                                                                                                            |
| MAILER_USERNAME          | SMTP server username                                                                                                        |
| MAILER_PASSWORD          | SMTP server password                                                                                                        |
| TRAEFIK_TLS_EMAIL        | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL    | Subdomain to route to the Traefik dashboard                                                                                 |
| POSTGRES_USER            | Name of admin user for database                                                                                             |
| POSTGRES_PASSWORD        | Password of admin user for database                                                                                         |
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

Redis is included in this stack specifically for Authelia session management. If you encounter permission issues with Redis being unable to write to the db file or generate temp files, the redis container may chown the mounted volume as root and then step down to the redis user, causing permission issues in some systems.

A `fix-redis.sh` script can be created to step into the container and chown volumes as the redis user to ensure the redis-server process has the permissions it needs to write to mounted volumes.

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

CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /authelia
      /redis
      /configuration.yaml
    /mosquitto
      /data
      /log
      /config
    /openldap
      /etc_ldap_slapd.d
      /ui
      /var_lib_ldap
    /postgres16
      /db_data
    /traefik
      /providers
      /certs
      /letsencrypt
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
- This stack focuses on core infrastructure services. Media acquisition/management services have been moved to separate stacks for better modularity
- The PostgreSQL database is configured with PostgreSQL 16 and increased max_connections (1000) to support multiple services
- Traefik includes custom middleware for increased request body size (2MB) to support applications with larger form submissions
- Redis is included specifically for Authelia session management
- Mosquitto MQTT broker is configured with ports 1883 (unencrypted) and 8883 (encrypted) for IoT device communication
- Make sure to rename the Authelia config file to "configuration.yml" if copying to the volume
- Make sure to rename the Wireguard config file to "config.yaml" if copying to the volume. If you need the config file, it needs to be in the directory that will be mounted BEFORE you run the container, otherwise it will create and mount a directory with the filename. [It's stupid](https://stackoverflow.com/a/42260979).
- Increased the Authelia buffer sizes because some services (Firefly III) will have massive requests that get rejected
