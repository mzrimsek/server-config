# syncthing-relay

This is a Syncthing relay server. It is used to help devices behind NATs and firewalls to establish connections to each other.

[Syncthing](https://docs.syncthing.net/index.html) is a tool to allow devices to synchronize files with each other. It is a decentralized solution, meaning that there is no central server that stores your files. Instead, your files are stored on your devices and synchronized with each other. [SyncTrazor](https://github.com/canton7/SyncTrayzor) is a good solution to manage your local Syncthing folders and how they are shared with other devices on your network. Using this in tandem with the Syncthing relay server is a good way to keep your files synchronized across your devices without them having to be on the same network.

## Ports

- `22067` - Relay server
- `22070` - Relay server status
