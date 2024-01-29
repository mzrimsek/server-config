# Duplicati

[Duplicati](https://www.duplicati.com/) is an open source file backup tool that is easily configurable to allow backup up files to local and remote locations.

## Environment variables

| Variable    | Description                                                                                                                 |
| ----------- | --------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR  | Root directory where service configuration files will live                                                                  |
| TIMEZONE    | Desired [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for containers (for applicable containers) |
| PUID        | User Id of the host user that containers should run under (for applicable containers)                                       |
| PGID        | Group Id of the host user that containers should run under (for applicable containers)                                      |
| BACKUP_ROOT | Root directory to configure backup jobs for (should be parent enough to capture any directories to be backed up)            |

## User Configuration

1. Add duplicati user `sudo adduser duplicati`
2. Get UID `id -u duplicati`
3. Get GID `id -g duplicati`
4. Give duplicati user access to backup directories `sudo setfacl -R -m u:duplicati:rw ${BACKUP_ROOT}`
5. Set the PUID and PGID environment variables in your `.env` file

## Notes

- [Theme Park](https://theme-park.dev/) is thrown in here to add a nice dark theme to application because light themes suck
- For interacting with cloud providers like Google Drive, Duplicati needs to run in host network mode to properly interact. [See here](https://forum.duplicati.com/t/google-drive-shared-drive-path-error/14036/3)
- When creating a backup that ties into Google Drive, Duplicati will not create the folder until it runs the job for the first time. This means after entering your AuthID and trying to "Test Connection" you will get a "Failed to Connect" error until the first backup job is run. This is expected behavior. If you run your job and see the folder get created and populated, it's probably configured correctly.
