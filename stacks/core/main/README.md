# Main

Goal is to have all the main services I use in one convenient place.

## Services

- Traefik - Container-first Reverse Proxy
- FireflyIII - Budgeting
- Vikunja - Tasks and todos
- Duplicati - Remote file backup

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable                   | Description                                                                                                                 |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR                 | Root directory where service configuration files will live                                                                  |
| TIMEZONE                   | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| PUID                       | User Id of the host user that containers should run under (for applicable containers)                                       |
| PGID                       | Group Id of the host user that containers should run under (for applicable containers)                                      |
| DATABASE_HOST              | Database connection host machine                                                                                            |
| DATABASE_USER              | Database connection username                                                                                                |
| DATABASE_PASSWORD          | Database connection password                                                                                                |
| MAILER_HOST                | SMTP server host                                                                                                            |
| MAILER_PORT                | SMTP server port                                                                                                            |
| MAILER_USERNAME            | SMTP server username                                                                                                        |
| MAILER_PASSWORD            | SMTP server password                                                                                                        |
| TRAEFIK_TLS_EMAIL          | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL      | Subdomain to route to the Traefik dashboard                                                                                 |
| TRAEFIK_DASHBOARD_USER     | [User credentials](https://doc.traefik.io/traefik/middlewares/http/basicauth/) to restrict access to Traefik dashboard      |
| FIREFLY_APP_KEY            | Randomly generated key used by Firefly for encryption                                                                       |
| FIREFLY_URL                | Subdomain to route to Firefly budgeting web interface                                                                       |
| FIREFLY_COMMAND_LINE_TOKEN | Token generated within Firefly to enable a daily CRON job for recurring transactions and auto-budgeting                     |
| VIKUNJA_JWT_SECRET         | Randomly generated key used by Vikunja for encryption                                                                       |
| VIKUNJA_URL                | Subdomain to route to Vikunja tasks web interface                                                                           |
| APP_THEME                  | [Addon themes](https://theme-park.dev/) for the media aquisition services (`organizr` is a great dark theme)                |
| BACKUP_ROOT1               | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |
| BACKUP_ROOT2               | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |
| AUTHELIA_HOST              | Internal network routing to authelia container (e.g. `authelia:9092`)                                                       |
| AUTHELIA_URL               | Subdomain to route to Authelia login page                                                                                   |

### File Structure

- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /duplicati
    /fireflyiii
    /traefik
      /providers
      /certs
    /vikunja
      /files
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

## Notes

- The stack provided mounts the media from a remote share. This could easily be modified to directly mount a directory by changing the media volume mount on the Jellyfin container in the docker compose file.
- Duplicati is being used for backing up some files to Google Drive. Duplicati can't interact to create files at it's destination when not running in Host mode for some reason. [See here](https://forum.duplicati.com/t/google-drive-shared-drive-path-error/14036/3)

### Removed services

- (11-24-22) Service dashboard was migrated out of this stack to be run in its own stack - the new service I am using has tighter integration with services that are more easily accessible from the device running the infrastructure stack, but it does not belong in that stack. [Found here](../../../services/homepage/)
- (12-1-22) Jellyfin migrated out of stack to be run on its own to run next to the media file it serves rather than fetching them over the network before serving them. [Found here](../../../services/jellyfin/)
- (12-11-23) Main Condensed stack created to pair down services that will be run back on the main server. [Found here](../main_condensed/)
