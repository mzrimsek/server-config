# Games

Set up various game servers.

## Factorio

- Server Data: Must have a directory to persist server data, mounted as a volume to `/factorio`

## Minecraft

This setup allows for potentially running several Minecraft server instances (each with their own volumes and such required), each with their proxy url. This also allows for a cleaner routing to servers due to the port no longer being required when connecting in the game client.

- World Data: Must have a directory to persist world data, mounted as a volume to `/data`

- Modpacks: Must have a directory containing the desired modpack as a zip, mounted as a volume to `/modpacks`

## Valheim

- Config: Must have a directory to persist server config, mounted as a volume to `/config`

- World Data: Must have a directory to persist world data, mounted as volume to `/opt/valheim`

## Terraria

- Config: Must have a directory to persist server config, mounted as a volume to `/config`
  - If using the same image, follow the instructions on the [DockerHub](https://hub.docker.com/r/beardedio/terraria) page to create the world prior to starting the container.
    - `sudo docker run --rm -it -v $HOME/terraria/config:/config --name=terraria_temp beardedio/terraria`
  - Directory should have the world file, banlist file, and serverconfig file
  - Update `serverconfig.txt` to set the password if desired - uncomment the line and update with your password
