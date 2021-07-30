# Setup Raspi Worker Node

1. Setup Raspbian Lite (no desktop environment) with Imaging Tool: https://www.raspberrypi.org/software/
2. Use raspi-config to set hostname, password, and enable SSH
3. Disable Swap: https://www.raspberrypi.org/forums/viewtopic.php?t=244130#p1490692
   - `sudo systemctl disable dphys-swapfile.service`
4. Enable cgroup memory: https://www.raspberrypi.org/forums/viewtopic.php?t=203128#p1315970
   - Add `cgroup_enable=cpuset cgroup_enable=memory` to the end of `/boot/cmdline.txt`
5. Install Docker: https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there
   1. `sudo apt update`
   2. Install required packages
   ```
   sudo apt install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
   ```
   3. `curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -`
   4. Add Docker repos
   ```bash
   echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
     $(lsb_release -cs) stable" | \
     sudo tee /etc/apt/sources.list.d/docker.list
   ```
   4. `sudo apt update`
   5. Install packages
   ```
   sudo apt install -y --no-install-recommends \
     docker-ce \
     cgroupfs-mount
   ```
   6. `sudo systemctl enable docker && sudo systemctl start docker`
   7. Test the install: `sudo docker run --rm arm32v7/hello-world`
6. (Optional) Enable remote Docker access: https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248
   1. Add or open `/etc/systemd/system/docker.service.d/remote-api.conf`
   2. Update the file
   ```
   [Service]
   ExecStart=
   ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
   ```
   3. Restart Docker: `sudo systemctl daemon-reload && sudo systemctl restart docker`
   4. Add as an endpoint to Portainer for remote management
7. Use systemd for container cgroup management: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
   1. `sudo mkdir /etc/docker`
   2. Add configuration
   ```bash
   cat <<EOF | sudo tee /etc/docker/daemon.json
   {
     "exec-opts": ["native.cgroupdriver=systemd"],
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "100m"
     },
     "storage-driver": "overlay2"
   }
   EOF
   ```
   3. `sudo systemctl enable docker && sudo systemctl daemon-reload && sudo systemctl restart docker`
