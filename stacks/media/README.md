# Media Stack

A fully functioning media acquisition stack.

## File Structure

```
/data
  /media (MEDIA_DIR)
    /tv
    /movies
    /music
    /books
      /uploads
      /library
    /downloads (DOWNLOADS_DIR)
      /complete
      /pending
  /config (CONFIG_DIR)
    /transmission
    /jellyfin
      /config
      /cache
    /prowlarr
    /sonarr
    /radarr
    /lidarr
    /readarr
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


You also need to get the PUID and PGID of the user that will be running the containers and make sure it has access to the files mounted to the container. This is to ensure the containers all have the necessary permissions they need to manipulate the files when they are organized into the respective libraries.

### Sonarr/Radarr/Lidarr/Readarr

Generally it's:

1. Add indexers in prowlarr
2. Open sonarr/radarr/lidarr/readarr
3. Add relevant media subfolder as content root
4. Add download client
5. Get API key from security settings
6. Add media management app in prowlarr
7. Repeat 2-6 with all media management apps
8. Sync indexers to apps in prowlarr

### Calibre

Important first note - make sure the directory you use to start your Calibre library is empty. Once you set things up, if you have books to import, you can drop them in the folder that is mounted to `/uploads` on the container. I distilled steps from [this useful post](https://academy.pointtosource.com/containers/ebooks-calibre-readarr/).

1. Open Calibre Preferences > Sharing Over the Web
3. Add account for readarr and for you to log into the content server
4. Enable the following:
  * Require auth to access the content server
  * Start the server on startup
5. Go to Calibre Preferences > Adding Books
6. Enable the following
  * Look for dups when copying to the library
  * Auto convert new books
  * Auto merge duplicates
7. Set uploads folder to `/uploads`
8. Open Calibre Web
  * default creds are admin//admin123
9. Update user creds to be more secure
10. Add send-to-Kindle email address for user
  * Go to Amazon > Account > Manage Content and Devices > Preferences > Personal Document Settings
11. Open Readarr
12. Add Calibre library
  * Set path to root path of library
  * Check "Use Calibre"
  * Enter creds to the content server (port 10206)
  * Enter Calibre readarr user creds
13. Enable "Rename Books" and "Replace Illegal Characters"
14. Add Remote Path Mapping
  * Remote Path: /Calibre_Library
  * Local Path: path to Calibre library on host