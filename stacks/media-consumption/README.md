# Media Consumption

A more paired down version of the media stack that is just services that consume media with any that gather or organize it.

## Services

- Jellyfin - TV, Movies, and Music Media Library Access
- Jellyfin Vue - A fun alternative interface to Jellyfin
- Kavita - eBook Library Access
- EmulatorJS - ROM Game Library Access

## Environment Variables

| Variable               | Description                                                                            |
| ---------------------- | -------------------------------------------------------------------------------------- |
| CONFIG_DIR             | Root directory where service configuration files will live                             |
| MEDIA_DIR              | Parent directory for tv, movie, etc. media libraries                                   |
| ROMS_DIR               | Parent directory for each ROM library                                                  |
| JELLYFIN_URL           | Subdomain to route to Jellyfin                                                         |
| JELLYFIN_VUE_URL       | Subdomain to route to Jellyfin Vue alternate interface                                 |
| KAVITA_URL             | Subdomain to route to Kavita                                                           |
| EMULATORJS_URL         | Subdomain to route to Emulator                                                         |
| TRAEFIK_PUBLIC_NETWORK | Public network that Traefik runs                                                       |
| PUID                   | User Id of the host user that containers should run under (for applicable containers)  |
| PGID                   | Group Id of the host user that containers should run under (for applicable containers) |
