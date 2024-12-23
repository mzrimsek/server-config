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

# Attempt to reboot
if reboot now; then
  # Reboot successful, send notification
  curl -s \
    -d "Watermelon-Pi rebooted at $formattedDate" \
    -H "Title=[PROXMOX] Reboot CRON" \
    -H "Tags=proxmox,watermelon-pi,reboot" \
    -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
    $topicurl

  # Check if curl command was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to send notification."
    exit 1
  fi
else
  # Reboot failed, send high priority notification
  curl -s \
    -d "Failed to reboot Watermelon-Pi at $formattedDate" \
    -H "Title=[PROXMOX] Reboot CRON - FAILURE" \
    -H "Tags=proxmox,watermelon-pi,reboot,failure" \
    -H "Priority=4" \
    -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
    $topicurl

  # Check if curl command was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to send high priority notification."
    exit 1
  fi
fi
