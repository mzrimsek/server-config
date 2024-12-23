#!/bin/bash

topic=infrastructure_alerts
formattedDate=$(date +"%Y-%m-%d %H:%M:%S")

# Check if NTFY_URL is set
if [ -z "$NTFY_URL" ]; then
  echo "Error: NTFY_URL is not set."
  exit 1
fi

# Check if NTFY_ACCESS_TOKEN is set
if [ -z "$NTFY_ACCESS_TOKEN" ]; then
  echo "Error: NTFY_ACCESS_TOKEN is not set."
  exit 1
fi

topicurl=${NTFY_URL}/${topic}

# Send notification about successful boot
curl -s \
  -d "Watermelon-Pi successfully booted at $formattedDate" \
  -H "Title=[PROXMOX] Boot Notification" \
  -H "Tags=proxmox,watermelon-pi,boot" \
  -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
  $topicurl

# Check if curl command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to send notification."
  exit 1
fi
