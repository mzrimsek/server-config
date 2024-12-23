#!/bin/bash

source ./common.sh

topic=infrastructure_alerts
formattedDate=$(date +"%Y-%m-%d %H:%M:%S")

echo "Validating environment variables..."
validate_ntfy_env_vars

echo "Waiting for 30 seconds before sending notification..."
sleep 30

echo "Sending notification..."
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
