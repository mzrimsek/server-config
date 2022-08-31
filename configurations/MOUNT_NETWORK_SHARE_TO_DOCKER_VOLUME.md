# Mount Network Share to Docker Volume

Mounting data from a centralized data store like a NAS makes a lot of sense. Instead of mounting to a point on the host you can mount directly to the remote share itself. I have the most permissive file settings right now but you could easily make them more locked down.

Add the following to your Docker Compose file and then mount the volume like any other volume.

```yaml
volumes:
  media:
    name: remote_media
    driver: local
    driver_opts:
      type: cifs
      device: ${TARGET_SHARE}
      o: addr=${SHARE_HOSTNAME},username=${SHARE_USER},password=${SHARE_PASS},file_mode=0777,dir_mode=0777
```

