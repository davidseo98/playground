#!/bin/bash

# Microsoft Teams Webhook URL
WEBHOOK_URL="Your webhook url, reference : https://learn.microsoft.com/ko-kr/azure/data-factory/how-to-send-notifications-to-teams?tabs=data-factory"

# Function to send a message to Microsoft Teams
send_teams_message() {
    local MESSAGE=$1
    curl -H "Content-Type: application/json" -X POST -d "{\"text\": \"$MESSAGE\"}" $WEBHOOK_URL
}

# Run the job
python job.py

# Capture the exit code
EXIT_CODE=$?

# Log the job status
if [ $EXIT_CODE -eq 0 ]; then
    send_teams_message "$(date) - job succeeded with exit code $EXIT_CODE"

else
    send_teams_message "job failed on $(hostname) with exit code $EXIT_CODE"
fi

exit $EXIT_CODE