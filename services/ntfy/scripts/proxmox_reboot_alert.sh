#!/bin/bash

source ./common.sh

topic=infrastructure_alerts
formattedDate=$(date +"%Y-%m-%d %H:%M:%S")

log "Validating environment variables..."
validate_ntfy_env_vars

log "Sending notification about upcoming reboot..."
send_ntfy_notification \
  "$topic" \
  "Watermelon-Pi will reboot in 30 seconds at $formattedDate" \
  "[PROXMOX] Reboot CRON" \
  "proxmox,watermelon-pi,reboot"

if [ $? -ne 0 ]; then
  log "Error: Failed to send notification."
  exit 1
fi
log "Notification sent successfully."

log "Waiting for 30 seconds before rebooting..."
sleep 30

log "Attempting to reboot Watermelon-Pi..."
if reboot now; then
  log "Reboot command executed successfully."
else
  log "Error: Failed to reboot Watermelon-Pi. Sending high priority notification..."
  send_ntfy_notification \
    "$topic" \
    "Failed to reboot Watermelon-Pi at $formattedDate" \
    "[PROXMOX] Reboot CRON - FAILURE" \
    "proxmox,watermelon-pi,reboot,failure" \
    4

  if [ $? -ne 0 ]; then
    log "Error: Failed to send high priority notification."
    exit 1
  fi
  log "High priority notification sent successfully."
fi
