# Backing Up Data

Backing up data to external directories is a pretty common thing to want to do to avoid data loss. Especially if you have a NAS or similar on your network to back up to.

## Setup

1. Create a target folder to backup to

- If using a NAS follow steps in the `MOUNTING_NETWORK_DRIVE` file to automatically mount the target share

2. Run `sudo rsync -r <source> <destination>`

The next logical step here is to add a script to backup whatever directories that need backed up and then add a cronjob to run the script on a timer.

## Container Alternative

Check out setting up [Duplicati](../duplicati/) to easily configure backups to local and remote locations
