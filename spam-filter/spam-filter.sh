#!/bin/bash

# Move to the mail directory
cd /var/mail/

# Define a whitelist of safe email addresses/domains
WHITELIST=("example.com" "john@example.com")

# Log the script's output to a file
LOG_FILE=/var/log/spam-filter.log
echo "Starting spam filter script at $(date)" >> "$LOG_FILE"

# Redirect all output to the log file
exec >> "$LOG_FILE" 2>&1

# Loop through all mailboxes and process the emails
for mailbox in *; do
    # Skip any non-mailbox files
    if [ ! -d "$mailbox" ]; then
        continue
    fi

    # Move to the mailbox directory
    cd "$mailbox"

    # Loop through all emails in the mailbox
    for email in *; do
        # Skip any non-email files
        if [ ! -f "$email" ]; then
            continue
        fi

        # Check if the email is in the whitelist
        if echo "$email" | grep -q -E "$(IFS='|'; echo "${WHITELIST[*]}")"; then
            # Move the email to the inbox folder
            mv "$email" ../.inbox/
        else
            # Check if the email is spam/junk
            if grep -q 'X-Spam-Flag: YES' "$email"; then
                # Move the email to the spam folder
                mv "$email" ../.spam/
            else
                # Move the email to the inbox folder
                mv "$email" ../.inbox/
            fi
        fi
    done

    # Move back to the mail directory
    cd ..
done
