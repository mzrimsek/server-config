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
    * Only need to do this if not deploying Portainer directly into the cluster to manage it
    * With Nodeport: `curl -L https://downloads.portainer.io/portainer-agent-k8s-nodeport.yaml -o portainer-agent-k8s.yaml; sudo k3s kubectl apply -f portainer-agent-k8s.yaml`
    * Verify the pod: `sudo k3s kubectl get pods --namespace=portainer`
5. (Optional) Install Helm to take advantage of premade Kubernetes packages: https://helm.sh/docs/intro/install/

## Add Worker Nodes

1. Join cluster: `curl -sfL https://get.k3s.io | K3S_URL=<master_node_ip>:6443 K3S_TOKEN=<nodetoken> sh -`
2. Verify the node joined on the master. May have to give it a minute for everything to initialize and it join.

## Enable NFS Provisioner to Interact with a NAS

There are a few things here:

1. k3s does not come with an nfs StorageClass out of the box
2. [v1.20 of k3s breaks the default image](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/issues/25#issuecomment-818762464) of the nfs provider being used, so a different image is required

### Steps

1. Set up a NAS with a file system accessible to the cluster
2. Install `nfs-common` on all nodes of the cluster
3. Apply the [provided tweaked deployment](../nfsVolumeProvisioner.yaml) to create the nfs provisioner and connect it to the NFS
4. Create a test pod - a file called "SUCCESS" should appear in the mount point when the pod creates
``` yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
spec:
  storageClassName: managed-nfs-storage
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi

---
kind: Pod
apiVersion: v1
metadata:
  name: test-pod
spec:
  containers:
  - name: test-pod
    image: gcr.io/google_containers/busybox:1.24
    command:
      - "/bin/sh"
    args:
      - "-c"
      - "touch /mnt/SUCCESS && exit 0 || exit 1"
    volumeMounts:
      - name: nfs-pvc
        mountPath: "/mnt"
  restartPolicy: "Never"
  volumes:
    - name: nfs-pvc
      persistentVolumeClaim:
        claimName: test-claim
```
5. Delete the test pod - the "SUCCESS" file should delete itself

Note: It seems this can be kind of finicky. Just leaving the test pod seems to make things work a little more consistently. If things get wonky and stop working, remove the test pod deployment, delete the folder created for the namespace the test pod was deployed in and then redeploy it to recreate.