# Main

Goal is to have all the main services I use in one convenient place.

## Services

- Traefik - Container-first Reverse Proxy
- FireflyIII - Budgeting
- Vikunja - Tasks and todos
- Jellyfin - Media server
- Dashboard - Configurable dashboard to easily access services
- Duplicati - Remote file backup
- Watchtower - Automated container image updates

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable                         | Description                                                                                                                 |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| TARGET_SHARE                     | Remote media share name                                                                                                     |
| SHARE_HOSTNAME                   | Remote media share hosting machine hostname                                                                                 |
| SHARE_USER                       | Remote media share accessing user username                                                                                  |
| SHARE_PASS                       | Remote media share accessing user password                                                                                  |
| CONFIG_DIR                       | Root directory where service configuration files will live                                                                  |
| TIMEZONE                         | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| PUID                             | User Id of the host user that containers should run under (for applicable containers)                                       |
| PGID                             | Group Id of the host user that containers should run under (for applicable containers)                                      |
| DATABASE_HOST                    | Database connection host machine                                                                                            |
| DATABASE_USER                    | Database connection username                                                                                                |
| DATABASE_PASSWORD                | Database connection password                                                                                                |
| MAILER_HOST                      | SMTP server host                                                                                                            |
| MAILER_PORT                      | SMTP server port                                                                                                            |
| MAILER_USERNAME                  | SMTP server username                                                                                                        |
| MAILER_PASSWORD                  | SMTP server password                                                                                                        |
| TRAEFIK_TLS_EMAIL                | Email for Traefik to use when Let's Encrypt executes its TLS Challenge for cert generation                                  |
| TRAEFIK_DASHBOARD_URL            | Subdomain to route to the Traefik dashboard                                                                                 |
| TRAEFIK_DASHBOARD_USER           | [User credentials](https://doc.traefik.io/traefik/middlewares/http/basicauth/) to restrict access to Traefik dashboard      |
| SERVICE_DASHBOARD_URL            | Subdomain to route to service shortcut dashboard                                                                            |
| FIREFLY_APP_KEY                  | Randomly generated key used by Firefly for encryption                                                                       |
| FIREFLY_URL                      | Subdomain to route to Firefly budgeting web interface                                                                       |
| FIREFLY_COMMAND_LINE_TOKEN       | Token generated within Firefly to enable a daily CRON job for recurring transactions and auto-budgeting                     |
| VIKUNJA_JWT_SECRET               | Randomly generated key used by Vikunja for encryption                                                                       |
| VIKUNJA_URL                      | Subdomain to route to Vikunja tasks web interface                                                                           |
| JELLYFIN_URL                     | Subdomain to route to Jellyfin media server web interface                                                                   |
| APP_THEME                        | [Addon themes](https://theme-park.dev/) for the media aquisition services (`organizr` is a great dark theme)                |
| BACKUP_ROOT1                     | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |
| BACKUP_ROOT2                     | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |
| WATCHTOWER_NOTIFICATION_PROVIDER | [Shoutrrr](https://containrrr.dev/shoutrrr/v0.5/services/overview/) notification provider                                   |
| WATCHTOWER_NOTIFICATION_URL      | [Shoutrrr](https://containrrr.dev/shoutrrr/v0.5/services/overview/) notification URL to get updates on Watchtower actions   |
| WATCHTOWER_UPDATE_INTERVAL       | Value in seconds to wait between checking containers for updates                                                            |

### File Structure

- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /dashboard
    /duplicati
    /fireflyiii
    /jellyfin
      /config
      /cache
    /traefik
      /providers
      /certs
    /vikunja
      /files
```

### Notes

- The stack provided mounts the media from a remote share. This could easily be modified to directly mount a directory by changing the media volume mount on the Jellyfin container in the docker compose file.
- Duplicati is being used for backing up some files to Google Drive. Duplicati can't interact to create files at it's destination when not running in Host mode for some reason. [See here](https://forum.duplicati.com/t/google-drive-shared-drive-path-error/14036/3)
