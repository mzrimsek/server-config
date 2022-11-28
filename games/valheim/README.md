# valheim

## Environment Variables

[See options](https://github.com/lloesche/valheim-server-docker#environment-variables)

| Variable        | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| CONFIG_DIR      | Root directory to where the Valheim volume should live          |
| TIMEZONE        | Server timezone                                                 |
| SERVER_NAME     | Public name of server that will display when being searched for |
| SERVER_PASSWORD | Password to connect to the server                               |

The defaults are update/restart/backup are

- Checks for updates every 15 min. Only updates if no one is connected.
- Backups run hourly regardless of recent activity.
- Restarts daily at 5am. Only restarts if no one is connected.
