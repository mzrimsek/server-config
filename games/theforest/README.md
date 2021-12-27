# The Forest

1. Go to https://steamcommunity.com/dev/managegameservers and register a login token using appid `242760`
2. Edit `config.cfg` in the `game` volume
  * Paste login token at `serverSteamAccount`

## Notes

To deal with conflicting ports for other hosted servers, I altered the `serverSteamPort`, `serverGamePort`, and `serverQueryPort` and mapped them accordingly in the docker config. If you don't need to change the ports you will need to update the docker config I have or you can grab the [original config](https://github.com/jammsen/docker-the-forest-dedicated-server)

I also updated `serverName` to a more easily searchable name, and `serverPassword`, and `serverPasswordAdmin` to secure values to lock the server down.