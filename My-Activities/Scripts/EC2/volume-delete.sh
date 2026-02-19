#!/bin/bash

echo "=========== Delete EBS Volume ==========="

read -p "Enter Volume ID to delete: " VOLUME_ID

if [[ -z "$VOLUME_ID" ]]; then
  echo "Error: Volume ID cannot be empty."
  exit 1
fi

read -p "Are you sure you want to delete volume $VOLUME_ID ? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

echo "Deleting volume $VOLUME_ID ..."

aws ec2 delete-volume --volume-id "$VOLUME_ID"

if [[ $? -eq 0 ]]; then
  echo "Volume $VOLUME_ID deleted successfully."
else
  echo "Failed to delete volume."
fi
