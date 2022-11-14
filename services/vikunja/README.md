# Vikunja

[Vikunja](https://vikunja.io/) is a handy to-do and task managing application. This setup assumes a [Postgres](../Postgres) database has been setup to persist data.

- Files: Must have a directory to mount as a volume to the api container at `/app/vikunja/files`

- Config: Must have a directory containing the provided `nginx.conf` mounted as a volume to the proxy container at `/etc/nginx/conf.d/default.conf`

## Notes

The Docker Compose configuration disables user registration. When setting up for the first time, set this flag to `"true"`, then switch it back to false if you want to restrict usage to just the first account. Probably a good idea in terms of security if the URL will be publicly accessible.