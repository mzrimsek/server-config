# Useful k3s Stuff

## Commands

### Remove a Node

1. Drain target node: `sudo k3s kubectl drain <node_name>`
2. Delete target node: `sudo k3s kubectl delete node <node_name>`

### Label Worker Node

1. `sudo k3s kubectl label node <node_name> node-role.kubernetes.io/worker=worker`

## Aliases

### Shortcut to kubectl

Gets to the control plane commands quicker while allowing to pass whatever arguments you normally would

```bash
k3sk() {
	sudo k3s kubectl $@
}
```

### Apply deployments with docker-compose-like environment variables

This uses a [small command line tool](https://github.com/mzrimsek/env-replace) I wrote in conjunction with the previous alias. Essentially allows for easy environment variable substitution when applying changes to the cluster.

```bash
k3sra() {
	env-replace $@ | k3sk apply -f -
}

k3srd() {
	env-replace $@ | k3sk delete -f -
}
```
