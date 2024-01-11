Enable remote Docker access: https://docs.docker.com/config/daemon/remote-access/

1.  Run `sudo systemctl edit docker.service`
2.  Add/edit the file

```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://127.0.0.1:2375
```

3. Restart Docker: `sudo systemctl daemon-reload && sudo systemctl restart docker.service`
4. Add as an endpoint to Portainer for remote management

## Snap install

https://www.reddit.com/r/docker/comments/qfe7ys/how_to_enable_remote_api_with_docker_thats_been/

https://gist.github.com/kekru/974e40bb1cd4b947a53cca5ba4b0bbe5#file-2-daemon-json

1. Find your `daemon.json` file at `/var/snap/docker/current/config`
2. Add the following to the file:

```
"hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2376"],
```

3. Restart the service `sudo systemctl daemon-reload && sudo systemctl restart snap.docker.dockerd.service`
