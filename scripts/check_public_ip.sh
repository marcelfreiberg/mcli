#!/bin/bash

# This script checks the public IP address and notifies the user if it changes

SLEEP_INTERVAL=3600
EMAIL_RECIPIENT="marcel.freiberg@outlook.com"
PUBLIC_IP_FILE="~/public_ip.txt"

# Check if dig is installed
if ! [ -x "$(command -v dig)" ]; then
  echo "dig command not found. Please install dig and try again."
  exit 1
fi

# Check if sendmail is installed
if ! [ -x "$(command -v sendmail)" ]; then
  echo "sendmail command not found. Please install sendmail and try again."
  exit 1
fi

# Read the previous public IP address from the file, or initialize it to an empty string if the file does not exist
if [ -f $PUBLIC_IP_FILE ]; then
  PREV_PUBLIC_IP=$(cat $PUBLIC_IP_FILE)
else
  PREV_PUBLIC_IP=""
fi

# Loop and check the public IP address every interval
while true; do
  # Use the dig command to retrieve the current public IP address
  PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

  # Check if the public IP address has changed
  if [ "$PUBLIC_IP" != "$PREV_PUBLIC_IP" ]; then
    # Notify the user of the change
    echo -e "Subject: check_public_ip\n\nPublic IP address has changed to $PUBLIC_IP" | sendmail $EMAIL_RECIPIENT
    
    # Save the current public IP address to the file
    echo $PUBLIC_IP > $PUBLIC_IP_FILE

    # Update the previous public IP address
    PREV_PUBLIC_IP="$PUBLIC_IP"
  fi

  # Sleep for the defined interval
  sleep $SLEEP_INTERVAL
done
