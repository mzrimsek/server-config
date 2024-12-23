#!/bin/bash

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

topicurl=${NTFY_URL}/${topic}

echo "Sending notification to $topicurl..."
curl -s \
  -d "Watermelon-Pi will reboot in 30 seconds at $formattedDate" \
  -H "Title: [PROXMOX] Reboot CRON" \
  -H "Tags: proxmox,watermelon-pi,reboot" \
  -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
  $topicurl

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
echo "Sending high priority notification to $topicurl..."
  curl -s \
    -d "Failed to reboot Watermelon-Pi at $formattedDate" \
    -H "Title: [PROXMOX] Reboot CRON - FAILURE" \
    -H "Tags: proxmox,watermelon-pi,reboot,failure" \
    -H "Priority: 4" \
    -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
    $topicurl

  if [ $? -ne 0 ]; then
    echo "Error: Failed to send high priority notification."
    exit 1
  fi
  echo "High priority notification sent successfully."
fi
