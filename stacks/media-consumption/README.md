# Media Consumption

A more paired down version of the media stack that is just services that consume media with any that gather or organize it.

## Services

- Jellyfin - TV, Movies, and Music Media Library Access
- Kavita - eBook Library Access

## Environment Variables

| Variable               | Description                                                |
| ---------------------- | ---------------------------------------------------------- |
| CONFIG_DIR             | Root directory where service configuration files will live |
| MEDIA_DIR              | Parent directory for tv, movie, etc. media libraries       |
| JELLYFIN_URL           | Subdomain to route to Jellyfin                             |
| KAVITA_URL             | Subdomain to route to Kavita                               |
| TRAEFIK_PUBLIC_NETWORK | Public network that Traefik runs                           |
