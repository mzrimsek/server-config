# Config Cluster

Using [k3s](https://rancher.com/docs/k3s/latest/en/quick-start/#install-script) over [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) due to more limited resources on devices that will be running as worker nodes

## Master Node Setup

1. Install k3s: `curl -sfL https://get.k3s.io | sh -`
    * Using Postgres as the datasource: `curl -sfL https://get.k3s.io | sh -s - server   --datastore-endpoint="postgres://<user>:<pass>@<db_host_ip>:5432/k3s?sslmode=disable"
    * Make sure to create the "k3s" database
  * k3s ships with Traefik 1.7. If wanting to use 2.x add the `--no-deploy traefik` flag to the install command to prevent the old installation from occurring
    * TODO: Add guide
2. Verify master node is running: `sudo k3s kubectl get nodes`
3. Get nodetoken to add worker nodes: `sudo cat /var/lib/rancher/k3s/server/node-token`
4. (Optional) Add Portainer Agent to enable cluster management: https://documentation.portainer.io/v2.0/endpoints/kubernetes/
    * With Nodeport: `curl -L https://downloads.portainer.io/portainer-agent-k8s-nodeport.yaml -o portainer-agent-k8s.yaml; sudo k3s kubectl apply -f portainer-agent-k8s.yaml`
    * Verify the pod: `sudo k3s kubectl get pods --namespace=portainer`

## Add Worker Nodes

1. Join cluster: `curl -sfL https://get.k3s.io | K3S_URL=<master_node_ip>:6443 K3S_TOKEN=<nodetoken> sh -`
2. Verify the node joined on the master. May have to give it a minute for everything to initialize and it join.