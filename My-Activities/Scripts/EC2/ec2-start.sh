#!/bin/bash

set -e

echo "======================================="
echo " AWS EC2 START INSTANCES - INTERACTIVE "
echo "======================================="
echo "======================================="
echo
echo "Choose option:"
echo "1) Start ALL stopped EC2 instances (NO CONFIRMATION)"
echo "2) Start SPECIFIC instance ID(s)"
echo

read -p "Enter your choice (1 or 2): " choice

REGION=$(aws configure get region)

if [[ -z "$REGION" ]]; then
  echo "ERROR: AWS region not configured. Run: aws configure"
  exit 1
fi

if [[ "$choice" == "1" ]]; then
    echo
    echo "Fetching all STOPPED EC2 instances in region: $REGION"

    INSTANCES=$(aws ec2 describe-instances \
      --filters Name=instance-state-name,Values=stopped \
      --query 'Reservations[].Instances[].InstanceId' \
      --output text)

    if [[ -z "$INSTANCES" ]]; then
        echo "No stopped instances found."
        exit 0
    fi

    echo "Starting all stopped EC2 instances..."
    echo "$INSTANCES"

    aws ec2 start-instances --instance-ids $INSTANCES

    echo "All stopped EC2 instances are being started."

elif [[ "$choice" == "2" ]]; then
    echo
    read -p "Enter EC2 Instance ID(s) (space separated): " INSTANCES

    if [[ -z "$INSTANCES" ]]; then
        echo "ERROR: No instance ID provided."
        exit 1
    fi

    echo
    echo "The following instances will be STARTED:"
    echo "$INSTANCES"
    echo

    read -p "Are you sure? (yes/no): " confirm
    [[ "$confirm" != "yes" ]] && echo "Aborted." && exit 0

    aws ec2 start-instances --instance-ids $INSTANCES

    echo "Selected EC2 instances are being started."

else
    echo "Invalid option."
    exit 1
fi
