#/bin/bash

# reset cluster
sudo kubeadm reset

# clean up left over config
sudo rm -rf /etc/cni/net.d

# clean up iptables entries
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

# restart docker to re-add port configurations
sudo service docker restart
