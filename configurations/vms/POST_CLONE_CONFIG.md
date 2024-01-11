# POST VM CLONE CONFIG

1. Get a new IP address for the VM

   ```bash
   sudo dhclient -r
   sudo dhclient
   ```

2. Update the hostname

   ```bash
    # Update the hostname
    sudo nano /etc/hostname

    # Update the hosts file
    sudo nano /etc/hosts

    # Reboot
    sudo reboot
   ```

3. Update user password

   ```bash
   sudo passwd $USER
   ```
