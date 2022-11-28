# valheim

## Environment Variables

[See options](https://github.com/lloesche/valheim-server-docker#environment-variables)

| Variable          | Description                                                                       |
| ----------------- | --------------------------------------------------------------------------------- |
| CONFIG_DIR        | Root directory to where the Valheim volume should live                            |
| TIMEZONE          | Server timezone                                                                   |
| SERVER_NAME       | Public name of server that will display when being searched for                   |
| SERVER_PASSWORD   | Password to connect to the server                                                 |
| STEAMCMD_ARGS     | An optional environment variable to modify the server launch command              |
| INSTANCE_MODIFIER | Optional string to differentiate multiple Valheim instances hosted on one machine |

The defaults are update/restart/backup are

- Checks for updates every 15 min. Only updates if no one is connected.
- Backups run hourly regardless of recent activity.
- Restarts daily at 5am. Only restarts if no one is connected.

## Notes

- [11/28/22] For the Mistlands public test, you can switch the server to use the beta by settings your STEAMCMD_ARGS to `-beta public-test -betapassword yesimadebackups`
