# pihole

Pihole is a great network-wide adblocking tool - orginally designed to run on a raspberry pi we can run it on any machine in a Docker container.

- Pihole Data: Must have a directory to persist pihole configuration files, mounted as a volume to '/etc/pihole'
- DNS Data: Must have a directory to persist dnsmasq configuration files, mounted as a volume to '/etc/dnsmasq.d'

Modify the '07-dhcp-options.conf' file and drop it in the 'dnsmasq.d' volume directory.

## Notes

If you run into issues where suddenly DNS queries are getting rejected and you have no idea why (especially if you're using PiHole as your main DNS resolver on your router), you may want to check the `/etc/pihole/pihole-FTL.conf` file and adjust your `RATE_LIMIT` setting. The default is 1000/60 - 1000 requests every 60 minutes, so you can easily use that to adjust the rate limiting up or down. Or just set it at 0/0 to disable rate limiting entirely. Once you update the config, make sure to restart the pihole container to apply the changes.
