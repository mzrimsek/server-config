Enable remote Docker access: https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248

1.  Add or open `/etc/systemd/system/docker.service.d/remote-api.conf`
2.  Update the file

```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
```

3. Restart Docker: `sudo systemctl daemon-reload && sudo systemctl restart docker`
4. Add as an endpoint to Portainer for remote management
