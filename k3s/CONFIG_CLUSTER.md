Using [k3s](https://rancher.com/docs/k3s/latest/en/quick-start/#install-script) over [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) due to more limited resources on devices that will be running as worker nodes

Master Node Setup

1. Install k3s: `curl -sfL https://get.k3s.io | sh -`
  * Using Postgres as the datasource: `curl -sfL https://get.k3s.io | sh -s - server   --datastore-endpoint="postgres://<user>:<pass>@<ip>:5432/k3s?sslmode=disable"
  * Make sure to create the "k3s" database
2. Verify master node is running: `sudo k3s kubectl get nodes`
3. (Optional) Allow pods to run on the master node: `sudo k3s kubectl taint node <master_node_name> node-role.kubernetes.io/master=:NoSchedule`
4. Get nodetoken to add worker nodes: `sudo cat /var/lib/rancher/k3s/server/node-token`

Add Worker Nodes

1. Join cluster: `curl -sfL https://get.k3s.io | K3S_URL=<master_node_ip>:6443 K3S_TOKEN=<nodetoken> sh -`
2. Verify the node joined on the master. May have to give it a minute for everything to initialize and it join.

Add Portainer Agent: https://documentation.portainer.io/v2.0/endpoints/kubernetes/