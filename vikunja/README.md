# Vikunja

[Vikunja](https://vikunja.io/) is a handy to-do and task managing application.

- Files: Must have a directory to mount as a volume to the api container at `/app/vikunja/files`

- Config: Must have a directory containing the provided `nginx.conf` mounted as a volume to the proxy container at `/etc/nginx/conf.d/default.conf`