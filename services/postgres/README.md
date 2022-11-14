# Postgres

[Postgres](https://www.postgresql.org/docs/13/index.html) is a great open source SQL database solution. [pgAdmin](https://www.pgadmin.org/) is a great open source database dashboard that allows administration and monitoring of databases.

- DB Data: Must have a directory to persist the database information, mounted as a volume to `/var/lib/postgresql/data` in the Postgres container
- Admin Data: Must have a directory to persist the admin panel information, mounted as a volume to `/var/lib/pgadmin` in the pgAdmin container
