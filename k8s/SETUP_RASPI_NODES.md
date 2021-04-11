1. Setup Raspbian Lite (no desktop environment) with Imaging Tool: https://www.raspberrypi.org/software/
2. Use raspi-config to set hostname, password, and enable SSH
3. Disable Swap: https://www.raspberrypi.org/forums/viewtopic.php?t=244130#p1490692
4. Enable cgroup memory: https://www.raspberrypi.org/forums/viewtopic.php?t=203128#p1315970
5. Install Docker: https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there
6. (Optional) Enable remote Docker access: https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248
7. Use systemd for container cgroup management: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
8. Install Kubernetes packages: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl