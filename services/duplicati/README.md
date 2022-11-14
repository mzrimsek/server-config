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

## Notes

- [Theme Park](https://theme-park.dev/) is thrown in here to add a nice dark theme to application because light themes suck
- For interacting with cloud providers like Google Drive, Duplicati needs to run in host network mode to properly interact. [See here](https://forum.duplicati.com/t/google-drive-shared-drive-path-error/14036/3)
