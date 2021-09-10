There are definitely use cases for mounting drives external to the main server to share data across machines or to consolidate it in one place to take advantage of backup procedures.

The following assumes a NAS or another network accessible share is configured.

Mount on startup:

1. Create folder to mount share - `sudo mkdir /media/share`
2. Open crontab - `sudo crontab -e`
3. Add a new line - `@reboot sudo mount -t cifs -o rw,username=<share_username>,password=<share_password>,uid=<connecting_username> //<machine_name>/<target_share> /media/share`