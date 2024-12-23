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
