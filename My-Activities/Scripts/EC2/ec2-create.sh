#!/bin/bash

echo "This script will create a new EC2 instance with below config:"
echo "AMI        : ami-051a31ab2f4d498f5"
echo "Type       : t2.micro"
echo "Key Pair   : first-ec2"
echo "Volume     : 8 GB"
echo "Name Tag   : first-ec2"
echo

read -p "Do you want to continue? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

echo "Creating EC2 instance..."

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-051a31ab2f4d498f5 \
  --instance-type t2.micro \
  --key-name first-ec2 \
  --count 1 \
  --block-device-mappings '[{"DeviceName":"/dev/xvda","Ebs":{"VolumeSize":8,"VolumeType":"gp2","DeleteOnTermination":true}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=first-ec2}]' \
  --query 'Instances[0].InstanceId' \
  --output text)

if [[ -z "$INSTANCE_ID" ]]; then
  echo "EC2 creation failed."
  exit 1
fi

echo "EC2 Instance created successfully."
echo "Instance ID: $INSTANCE_ID"

echo "Waiting for instance to enter running state..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "-------------------------------------------"
echo "Instance ID : $INSTANCE_ID"
echo "Public IP   : $PUBLIC_IP"
echo "SSH Command : ssh -i first-ec2.pem ec2-user@$PUBLIC_IP"
echo "-------------------------------------------"
