# Jellyfin

[Jellyfin](https://jellyfin.org/) is an open source Plex alternative that allows you to organize and view various media types.

[Jellyseerr](https://github.com/Fallenbagel/jellyseerr) is a media request interface that works with Sonarr and Radarr to populate your Jellyfin library without giving your end users access to the underlying media request services.

[Wizarrrr](https://github.com/Wizarrrr/wizarr/tree/v2) helps assist with managing access to your Jellyfin server, as well as providing assistance in onboarding new users in how to use the service.

[Jellystat](https://hub.docker.com/r/cyfershepard/jellystat) provides insights into your Jellyfin server, including user activity, library statistics, and more.

At one point, for my setup in particular I mounted volumes from my NAS to leverage the central data store I have setup. I have since migrated the container to the NAS for direct file access but have left a docker-compose configuration as reference regardless.
