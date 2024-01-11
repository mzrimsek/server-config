Enable remote Docker access: https://docs.docker.com/config/daemon/remote-access/

1.  Run `sudo systemctl edit snap.docker.dockerd.service` - your service might be different if you're not using the snap that comes with Ubuntu when installing.

    - You can list all services with `systemctl list-units --type=service` to find what yours is called.

2.  Add/edit the file

```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://127.0.0.1:2375
```

3. Restart Docker: `sudo systemctl daemon-reload && sudo systemctl restart snap.docker.dockerd.service`
4. Add as an endpoint to Portainer for remote management
