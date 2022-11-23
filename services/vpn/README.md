# vpn

Built on Wireguard with a nifty web interface for configuring devices to connect to your tunnel

If you are mounting a config file, ensure the directory and config.yaml file exists in the location you intend to mount as a volume to `/config.yaml`. If you let Docker create the host directories and file it will create a _directory_ called `config.yaml` rather than a file. [Ref](https://stackoverflow.com/a/42260979)
