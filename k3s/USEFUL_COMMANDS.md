# Useful k3s Commands

## Remove a Node

1. Drain target node: `sudo k3s kubectl drain <node_name>`
2. Delete target node: `sudo k3s kubectl delete node <node_name>`