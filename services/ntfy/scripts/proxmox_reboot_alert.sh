#!/bin/bash

source ./common.sh

topic=infrastructure_alerts
formattedDate=$(date +"%Y-%m-%d %H:%M:%S")

echo "Checking if NTFY_URL and NTFY_ACCESS_TOKEN are set..."
if [ -z "$NTFY_URL" ]; then
  echo "Error: NTFY_URL is not set."
  exit 1
fi
echo "NTFY_URL is set to $NTFY_URL"

if [ -z "$NTFY_ACCESS_TOKEN" ]; then
  echo "Error: NTFY_ACCESS_TOKEN is not set."
  exit 1
fi
echo "NTFY_ACCESS_TOKEN is set."

echo "Sending notification..."
send_ntfy_notification \
  "$topic" \
  "Watermelon-Pi will reboot in 30 seconds at $formattedDate" \
  "[PROXMOX] Reboot CRON" \
  "proxmox,watermelon-pi,reboot"

if [ $? -ne 0 ]; then
  echo "Error: Failed to send notification."
  exit 1
fi
echo "Notification sent successfully."

echo "Waiting for 30 seconds before rebooting..."
sleep 30

echo "Rebooting Watermelon-Pi..."
if reboot now; then
  echo "Reboot command executed successfully."
else
  echo "Error: Failed to reboot Watermelon-Pi."
  echo "Sending high priority notification..."
  send_ntfy_notification \
    "$topic" \
    "Failed to reboot Watermelon-Pi at $formattedDate" \
    "[PROXMOX] Reboot CRON - FAILURE" \
    "proxmox,watermelon-pi,reboot,failure" \
    4

  if [ $? -ne 0 ]; then
    echo "Error: Failed to send high priority notification."
    exit 1
  fi
  echo "High priority notification sent successfully."
fi
