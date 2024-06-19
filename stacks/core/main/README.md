# Main Condensed

When I decided to pair down and migrate services back to my main server to use the secondary as a ProxMox machine I took the main stack and removed anything that was no longer necessary or already running on the main server. This is the result.

## Services

- FireflyIII - Budgeting
- Vikunja - Tasks and todos

## Setup

1. Copy down docker compose file
2. Create dotenv file configured with values from the docker compose file
3. Run `docker-compose --env-file .env up -d`

### Environment

| Variable               | Description                                                                                                                 |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR             | Root directory where service configuration files will live                                                                  |
| TIMEZONE               | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| DATABASE_HOST          | Database connection host machine                                                                                            |
| DATABASE_USER          | Database connection username                                                                                                |
| DATABASE_PASSWORD      | Database connection password                                                                                                |
| MAILER_HOST            | SMTP server host                                                                                                            |
| MAILER_PORT            | SMTP server port                                                                                                            |
| MAILER_USERNAME        | SMTP server username                                                                                                        |
| MAILER_PASSWORD        | SMTP server password                                                                                                        |
| FIREFLY_APP_KEY        | Randomly generated key used by Firefly for encryption                                                                       |
| FIREFLY_URL            | Subdomain to route to Firefly budgeting web interface                                                                       |
| VIKUNJA_JWT_SECRET     | Randomly generated key used by Vikunja for encryption                                                                       |
| VIKUNJA_URL            | Subdomain to route to Vikunja tasks web interface                                                                           |
| TRAEFIK_PUBLIC_NETWORK | Public network that Traefik runs                                                                                            |

### File Structure

- CONFIG_DIR subdirectories will likely generate themselves as containers spin up. The ones that have additional configuration may need to be generated in advance before the containers mount volumes they may expect configuration files to reside in.

```
/data
  /config (CONFIG_DIR)
    /fireflyiii
      /certs
    /vikunja
      /files
```
