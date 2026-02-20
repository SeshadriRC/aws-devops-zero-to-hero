#!/bin/bash

echo "=========== EC2 Instance Creation Script ==========="

read -p "Enter AWS Region (example: ap-south-1): " REGION
read -p "Enter AMI ID: " AMI
read -p "Enter Instance Type (example: t2.micro): " TYPE
read -p "Enter Key Pair Name: " KEY_NAME
read -p "Enter Root Volume Size (GB): " VOL_SIZE
read -p "Enter Instance Name Tag: " NAME_TAG

echo
echo "This script will create a new EC2 instance with below config:"
echo "Region     : $REGION"
echo "AMI        : $AMI"
echo "Type       : $TYPE"
echo "Key Pair   : $KEY_NAME"
echo "Volume     : ${VOL_SIZE} GB"
echo "Name Tag   : $NAME_TAG"
echo

read -p "Do you want to continue? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "❌ Aborted."
  exit 0
fi

echo "🚀 Creating EC2 instance..."

INSTANCE_ID=$(aws ec2 run-instances \
  --region "$REGION" \
  --image-id "$AMI" \
  --instance-type "$TYPE" \
  --key-name "$KEY_NAME" \
  --count 1 \
  --block-device-mappings "[{\"DeviceName\":\"/dev/xvda\",\"Ebs\":{\"VolumeSize\":$VOL_SIZE,\"VolumeType\":\"gp3\",\"DeleteOnTermination\":true}}]" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NAME_TAG}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

if [[ -z "$INSTANCE_ID" || "$INSTANCE_ID" == "None" ]]; then
  echo "❌ EC2 creation failed."
  exit 1
fi

echo "✅ EC2 Instance created successfully."
echo "Instance ID: $INSTANCE_ID"

echo "⏳ Waiting for instance to enter running state..."
aws ec2 wait instance-running --region "$REGION" --instance-ids "$INSTANCE_ID"

PUBLIC_IP=$(aws ec2 describe-instances \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "-------------------------------------------"
echo "Instance ID : $INSTANCE_ID"
echo "Public IP   : $PUBLIC_IP"
echo "SSH Command : ssh -i $KEY_NAME.pem ec2-user@$PUBLIC_IP"
echo "-------------------------------------------"
