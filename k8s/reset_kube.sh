#/bin/bash

echo "Remove/Leave Cluster"
sudo kubeadm reset

echo "Clean Leftover Configs"
sudo rm -rf /etc/cni/net.d
sudo rm -rf $HOME/.kube

echo "Wipe iptables Entries"
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

echo "Restart Docker Service to Read Port Mappings"
sudo service docker restart

echo "Reset Complete"
