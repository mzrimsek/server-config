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

### Kavita Email Configuration

Run the stack once to generate the default appsettings.json file, then modify the `TokenKey` with a random string and fill in each of the blank `SMTP` fields.

Once the email service is up navigate to the Kavita Admin dashboard, then to the Email page and provide `http://<server_ip>:5003` as the "Email Service URL".

If you are attempting to "Send to Kindle" you will need to ensure that your Amazon account is setup to allow files from email sender.
