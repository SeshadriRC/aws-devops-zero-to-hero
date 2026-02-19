#!/bin/bash

read -p "Enter EC2 Instance ID to delete: " INSTANCE_ID

if [[ -z "$INSTANCE_ID" ]]; then
  echo "Error: Instance ID cannot be empty."
  exit 1
fi

read -p "Are you sure you want to delete instance $INSTANCE_ID ? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

echo "Terminating instance $INSTANCE_ID ..."

aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"

if [[ $? -eq 0 ]]; then
  echo "Instance $INSTANCE_ID termination initiated successfully."
else
  echo "Failed to terminate instance."
fi
