# Media Stack

A fully functioning media acquisition stack.

## Media File Structure

```
/media
  /tv
  /movies
  /music
  /books
  /downloads
    /complete
    /pending
```

## Included Applications

- Transmission - Download client
- Jellyfin - Media player
- Prowlarr - Indexer Management
- Sonarr - TV Show Management
- Radarr - Movie Management
- Lidarr - Music Management
- Readarr - Book Management


## Configuration

Generally it's:

1. Add indexers in prowlarr
2. Open sonarr/radarr/lidarr/readarr
3. Add relevant media subfolder as content root
4. Add download client
5. Get API key from security settings
6. Add media management app in prowlarr
7. Repeat 2-6 with all media management apps
8. Sync indexers to apps in prowlarr

You also need to get the PUID and PGID of the user that will be running the containers and make sure it has access to the files mounted to the container. This is to ensure the containers all have the necessary permissions they need to manipulate the files when they are organized into the respective libraries.