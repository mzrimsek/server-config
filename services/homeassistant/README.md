# Home Assistant

Set up a local [Home Assistant](https://www.home-assistant.io/) instance to control smart devices on the network.

- Configuration: Must have a directory to persist integration and device configuration, mounted as a volume to `/config`

## Notes

I revamped my home automation setup and ended up [installing Home Assistant on a Raspberry Pi](https://www.home-assistant.io/installation/) to get more of the features that the OS installation offers. After spending some time with it I'd recommend this approach over the Docker container if you want to spin up a more long term solution with room to evolve more easily. If you just want to test it out and play around with it I'd spin up a container and check it out that way (unless you have a Raspi collecting dust somewhere and want to install the full OS. I'm not your dad I can't tell you want to do).

Relevant configuration files:
* automation.yaml
* configuration.yaml
  * Make sure to update $PROXY_URL or remove it if you are not running behind a reverse proxy

[HACS](https://hacs.xyz/docs/setup/prerequisites) is full of great community integrations