# Mounting a Network Drive

There are definitely use cases for mounting drives external to the main server to share data across machines or to consolidate it in one place to take advantage of backup procedures.

## Setup

The following assumes a NAS or another network accessible share is configured.

Mount on startup:

1. Create folder to mount share - `sudo mkdir /media/share`
2. Open crontab - `sudo crontab -e`
3. Add a new line - `@reboot sudo mount -t cifs -o rw,username=<share_username>,password=<share_password>,uid=<connecting_username> //<machine_name>/<target_share> /media/share`

## Troubleshooting

Sometimes you might run into a "stale file handle" error when trying to navigate to your mounted drive in the terminal. The files are all accessible so functionality shouldn't be interrupted, but trying to navigate through the files will be a pain. [This article](https://www.cyberciti.biz/tips/nfs-stale-file-handle-error-and-solution.html) talks about how to fix it.

Essentially you need to forcibly unmount and remount the drive to resolve the issue.

One thing to note is that any containers that rely on the data in that drive will have their functionality interrupted by virtue of their volume mounts being broken. You will have to restart these containers to get them up and running with full functionality again.