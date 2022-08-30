Fail2ban is useful for reducing attack vectors on exposed machines.

This article was useful: https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/

1. `sudo apt update && sudo apt upgrade` - update packages
2. `sudo apt install fail2ban` - install fail2ban
3. `sudo systemctl status fail2ban` - confirm is running
4. `sudo cp /etc/fail2ban/jail.{conf,local}` - create local copy of default config to edit
5. Update config file by updating the `ignoreip` line to allow all local network connections
  * `ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24`