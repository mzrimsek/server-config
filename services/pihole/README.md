# pihole

Pihole is a great network-wide adblocking tool - orginally designed to run on a raspberry pi we can run it on any machine in a Docker container.

- Pihole Data: Must have a directory to persist pihole configuration files, mounted as a volume to '/etc/pihole'
- DNS Data: Must have a directory to persist dnsmasq configuration files, mounted as a volume to '/etc/dnsmasq.d'

Modify the '07-dhcp-options.conf' file and drop it in the 'dnsmasq.d' volume directory.
