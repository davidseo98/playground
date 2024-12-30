#!/bin/bash

WEBHOOK_URL="Your webhook url, reference : https://learn.microsoft.com/ko-kr/azure/data-factory/how-to-send-notifications-to-teams?tabs=data-factory"

send_teams_message() {
    local EXIT_CODE=$1
    local JOB_NAME=$2
    local MESSAGE="$JOB_NAME has failed with exit code $EXIT_CODE"


    if [ $EXIT_CODE -ne 0 ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"text\": \"$MESSAGE\"}" $WEBHOOK_URL
    fi
}

# Execute job 1 and check exit code
python job.py
EXIT_CODE=$?
send_teams_message $EXIT_CODE job1

# Execute job 2 and check exit code
python job2.py
EXIT_CODE=$?
send_teams_message $EXIT_CODE job2

exit $EXIT_CODE