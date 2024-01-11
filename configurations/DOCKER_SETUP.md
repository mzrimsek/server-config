# Install Docker

1. Clean up old Docker installs

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

2. Add apt repository

```bash

# Add Docker's official GPG key:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

```

3. Install latest version

```bash

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```

4. Verify install

```bash

sudo docker run hello-world

```

Docs: https://docs.docker.com/engine/install/ubuntu/

# Enable remote Docker access

1.  Run `sudo systemctl edit docker.service`
2.  Add/edit the file

```

[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375

```

3. Restart Docker: `sudo systemctl daemon-reload && sudo systemctl restart docker.service`
4. Add as an endpoint to Portainer for remote management using API method

Docs: https://docs.docker.com/config/daemon/remote-access/
