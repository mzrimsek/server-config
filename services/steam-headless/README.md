# steam-headless

There is some setup to do - https://github.com/Steam-Headless/docker-steam-headless/blob/master/docs/docker-compose.md

Make sure to add your `GAMES_DIR` to Steam as a Library in the settings.

## Variables

| Environment Variable | Description                            |
| -------------------- | -------------------------------------- |
| USER_PASSWORD        | Default User Password                  |
| CONFIG_DIR           | Directory to store configuration files |
| GAMES_DIR            | Directory to store games               |

## Notes on Games

I have tested games that use Jackbox.tv and while they launch fine, the games require the ability to connect to Jackbox.tv and it seems the container gets blocked by Cloudflare. I have tried a few things to attempt to run traffic through a VPN to no success. For now the workaround seems to be having a computer on the local network to stream the game from inside the container rather than having it installed locally.
