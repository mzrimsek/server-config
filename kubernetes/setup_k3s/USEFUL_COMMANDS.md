# Useful k3s Commands

## Remove a Node

1. Drain target node: `sudo k3s kubectl drain <node_name>`
2. Delete target node: `sudo k3s kubectl delete node <node_name>`

## Label Worker Node

1. `sudo k3s kubectl label node <node_name> node-role.kubernetes.io/worker=worker`