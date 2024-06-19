# Postgres

[Postgres](https://www.postgresql.org/docs/13/index.html) is a great open source SQL database solution. [pgAdmin](https://www.pgadmin.org/) is a great open source database dashboard that allows administration and monitoring of databases.

- DB Data: Must have a directory to persist the database information, mounted as a volume to `/var/lib/postgresql/data` in the Postgres container
- Admin Data: Must have a directory to persist the admin panel information, mounted as a volume to `/var/lib/pgadmin` in the pgAdmin container
  - PUID and PGID of this directory must both be 5050

## Notes

- (12/11/22) After upgrading my OS running my pgAdmin container I got a lot of file permission issues. Turns out the PUID and PGID of the directory must be 5050. Genuinely unclear on how to set these IDs as what the container should run as to aleviate these issues (like I do with other containers). I'm sure there's a better way to do it, but for now the work around is a small script to `chown` the pgAdmin data directory and restart the container I can run if/when the container dies.
