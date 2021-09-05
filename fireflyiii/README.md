# Firefly III

[Firefly III](https://www.firefly-iii.org/) is a YNAB-like, open source budgeting application.  This setup assumes a [Postgres](../Postgres) database has been setup to persist data.

- Upload Data: Must have a directory to persist application uploads, mounted as a volume to `/var/www/html/storage/upload`

## Using a Reverse Proxy

The `APP_URL` environment variable needs to be set to the url your installation will live at if it is running behind a reverse proxy (such as Traefik). Without this setting account creation and login does not work.

## Recurring Transations

Some features like recurring transactions require a cron job running to trigger the creation of these transactions. This setup includes a container to run a cron job that will hit the Firefly III API and create these transations daily. The setup takes a few steps though

1. Create the stack with the `APP_TOKEN` environment variable set to nothing
2. Create account and login to app
3. Navigate to Options > Profile > Command line token
4. Copy token and set `APP_TOKEN` environment variable with this value
5. Restart the stack

