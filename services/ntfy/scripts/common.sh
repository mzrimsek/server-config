#!/bin/bash

log() {
  local message=$1
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $message"
}

validate_ntfy_env_vars() {
  if [ -z "$NTFY_URL" ]; then
    log "Error: NTFY_URL is not set."
    exit 1
  fi
  log "NTFY_URL is set to $NTFY_URL"

  if [ -z "$NTFY_ACCESS_TOKEN" ]; then
    log "Error: NTFY_ACCESS_TOKEN is not set."
    exit 1
  fi
  log "NTFY_ACCESS_TOKEN is set."
}

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
    log "Error: Failed to send notification."
    exit 1
  fi
  log "Notification sent successfully to $topicurl"
}