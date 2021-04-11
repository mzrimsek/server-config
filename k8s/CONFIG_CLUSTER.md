1. Install Kubernetes packages: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
2. `sudo kubeadm init`
3. Copy generated command and run it on nodes to join them to the cluster
4. Copy config
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
5. Install network interface that fits your needs: https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/
  * Fabric or Weave seem to be good ones

References:
* https://carlosedp.medium.com/building-a-hybrid-x86-64-and-arm-kubernetes-cluster-e7f94ff6e51d
* https://gist.github.com/rkaramandi/44c7cea91501e735ea99e356e9ae7883