#!/bin/bash

source ./common.sh

topic=infrastructure_alerts
formattedDate=$(date +"%Y-%m-%d %H:%M:%S")

log "Validating environment variables..."
validate_ntfy_env_vars

log "Waiting for 30 seconds before sending boot notification..."
sleep 30

log "Sending notification about successful boot..."
send_ntfy_notification \
  "$topic" \
  "Watermelon-Pi successfully booted at $formattedDate" \
  "[PROXMOX] Boot Notification" \
  "proxmox,watermelon-pi,boot"

if [ $? -ne 0 ]; then
  echo "Error: Failed to send notification."
  exit 1
fi
echo "Notification sent successfully."
