#!/bin/bash

echo "=========== Create EBS Volume ==========="

read -p "Enter Availability Zone (example: us-east-1a): " AZ
read -p "Enter Volume Size in GB (example: 8): " SIZE
read -p "Enter Volume Type (gp2/gp3/io1/io2) [default: gp2]: " TYPE
TYPE=${TYPE:-gp2}

read -p "Enter Volume Name Tag: " NAME

if [[ -z "$AZ" || -z "$SIZE" || -z "$NAME" ]]; then
  echo "Error: AZ, Size and Name are mandatory."
  exit 1
fi

echo
echo "You are about to create volume:"
echo "AZ          : $AZ"
echo "Size        : ${SIZE}GB"
echo "Type        : $TYPE"
echo "Name Tag    : $NAME"
echo

read -p "Proceed? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

VOLUME_ID=$(aws ec2 create-volume \
  --availability-zone "$AZ" \
  --size "$SIZE" \
  --volume-type "$TYPE" \
  --tag-specifications "ResourceType=volume,Tags=[{Key=Name,Value=$NAME}]" \
  --query 'VolumeId' \
  --output text)

if [[ -z "$VOLUME_ID" ]]; then
  echo "Volume creation failed."
  exit 1
fi

echo
echo "Volume created successfully."
echo "Volume ID: $VOLUME_ID"
