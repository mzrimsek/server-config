1. Disable Swap: https://www.raspberrypi.org/forums/viewtopic.php?t=244130
2. Enable cgroup memory: https://www.raspberrypi.org/forums/viewtopic.php?t=203128#p1315970
3. Install Docker: https://withblue.ink/2019/07/13/yes-you-can-run-docker-on-raspbian.html#:~:text=Turns%20out%20there's%20plenty%20of,can%20also%20install%20Docker%20Compose.
4. (Optional) Enable remote Docker access: https://stackoverflow.com/questions/40591356/enable-docker-remote-api-raspberry-pi-raspbian/40609248#40609248
5. Use systemd for container cgroup management: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
6. Install Kubernetes packages: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
