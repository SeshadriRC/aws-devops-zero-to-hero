#!/bin/bash

set -e

echo "======================================="
echo " AWS EC2 STOP INSTANCES - INTERACTIVE "
echo "======================================="
echo
echo "Choose option:"
echo "1) Stop ALL running EC2 instances (NO CONFIRMATION)"
echo "2) Stop SPECIFIC instance ID(s)"
echo

read -p "Enter your choice (1 or 2): " choice

REGION=$(aws configure get region)

if [[ -z "$REGION" ]]; then
  echo "ERROR: AWS region not configured. Run: aws configure"
  exit 1
fi

if [[ "$choice" == "1" ]]; then
    echo
    echo "Fetching all RUNNING EC2 instances in region: $REGION"

    INSTANCES=$(aws ec2 describe-instances \
      --filters Name=instance-state-name,Values=running \
      --query 'Reservations[].Instances[].InstanceId' \
      --output text)

    if [[ -z "$INSTANCES" ]]; then
        echo "No running instances found."
        exit 0
    fi

    echo "Stopping all running EC2 instances..."
    echo "$INSTANCES"

    aws ec2 stop-instances --instance-ids $INSTANCES

    echo "All running EC2 instances are being stopped."

elif [[ "$choice" == "2" ]]; then
    echo
    read -p "Enter EC2 Instance ID(s) (space separated): " INSTANCES

    if [[ -z "$INSTANCES" ]]; then
        echo "ERROR: No instance ID provided."
        exit 1
    fi

    echo
    echo "The following instances will be STOPPED:"
    echo "$INSTANCES"
    echo

    read -p "Are you sure? (yes/no): " confirm
    [[ "$confirm" != "yes" ]] && echo "Aborted." && exit 0

    aws ec2 stop-instances --instance-ids $INSTANCES

    echo "Selected EC2 instances are being stopped."

else
    echo "Invalid option."
    exit 1
fi
