#!/bin/bash

send_ntfy_notification() {
  local topic=$1
  local message=$2
  local title=$3
  local tags=$4
  local priority=$5

  local topicurl=${NTFY_URL}/${topic}

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