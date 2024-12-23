
#!/bin/bash

send_ntfy_notification() {
  local message=$1
  local title=$2
  local tags=$3
  local priority=$4

  curl -s \
    -d "$message" \
    -H "Title: $title" \
    -H "Tags: $tags" \
    ${priority:+-H "Priority: $priority"} \
    -H "Authorization: Bearer $NTFY_ACCESS_TOKEN" \
    $topicurl

  if [ $? -ne 0 ]; then
    echo "Error: Failed to send notification."
    exit 1
  fi
}