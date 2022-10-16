# Main

Goal is to have all the main services I use in one convenient place.

## Services

- Traefik - Container-first Reverse Proxy
- FireflyIII - Budgeting
- Vikunja - Tasks and todos
- Jellyfin - Media server
- Dashboard - Configurable dashboard to easily access services

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable                   | Description                                                                                                                 |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| TARGET_SHARE               | Remote media share name                                                                                                     |
| SHARE_HOSTNAME             | Remote media share hosting machine hostname                                                                                 |
| SHARE_USER                 | Remote media share accessing user username                                                                                  |
| SHARE_PASS                 | Remote media share accessing user password                                                                                  |
| CONFIG_DIR                 | Root directory where service configuration files will live                                                                  |
| TIMEZONE                   | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
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
| SERVICE_DASHBOARD_URL      | Subdomain to route to service shortcut dashboard                                                                            |
| FIREFLY_APP_KEY            | Randomly generated key used by Firefly for encryption                                                                       |
| FIREFLY_URL                | Subdomain to route to Firefly budgeting web interface                                                                       |
| FIREFLY_COMMAND_LINE_TOKEN | Token generated within Firefly to enable a daily CRON job for recurring transactions and auto-budgeting                     |
| VIKUNJA_JWT_SECRET         | Randomly generated key used by Vikunja for encryption                                                                       |
| VIKUNJA_URL                | Subdomain to route to Vikunja tasks web interface                                                                           |
| JELLYFIN_URL               | Subdomain to route to Jellyfin media server web interface                                                                   |

### File Structure

- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /traefik
      /providers
      /certs
    /dashboard
    /fireflyiii
    /vikunja
      /files
    /jellyfin
      /config
      /cache
```

### Notes

- The stack provided mounts the media from a remote share. This could easily be modified to directly mount a directory by changing the media volume mount on the Jellyfin container in the docker compose file.
