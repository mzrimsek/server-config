# Minecraft

This stack allows you to set up multiple Minecraft servers on a single machine without having to manually expose ports for each instance.

## Environment Variables

[See options](https://github.com/itzg/docker-minecraft-server/blob/master/README.md)

| Variable                   | Description                                               |
| -------------------------- | --------------------------------------------------------- |
| CONFIG_DIR                 | Root directory to where the Minecraft volumes should live |
| SERVER_1_INSTANCE_MODIFIER | Unique identifier for server 1                            |
| SERVER_1_MODPACK           | Server 1 CurseForge modpack zip file name                 |
| SERVER_2_INSTANCE_MODIFIER | Unique identifier for server 2                            |
| SERVER_PROXY_URL           | Base url of server hosting instances                      |
