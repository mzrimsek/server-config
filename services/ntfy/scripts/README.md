# Scripts

These assume you have the $NTFY_URL set to your base instance url, access token auth enabled, and the $NTFY_TOKEN set to your access token. You should use a unique access token for at least each service you are using, maybe even each script.

- prommox_reboot_alert.sh - Reboots the target Proxmox system and sends a notification to the specified NTFY service.
- promoxmox_successful_boot_alert.sh - Sends a notification to the specified NTFY service when the target Proxmox system has successfully booted.
