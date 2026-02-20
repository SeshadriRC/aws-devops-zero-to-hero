#!/bin/bash

read -p "Enter AWS Region (example: ap-south-1): " REGION
read -p "Enter Key Pair Name: " KEY_NAME

if [[ -z "$REGION" || -z "$KEY_NAME" ]]; then
  echo "❌ Region and Key Name cannot be empty"
  exit 1
fi

KEY_DIR="$HOME/aws-keys"
mkdir -p "$KEY_DIR"

echo "Creating key pair '$KEY_NAME' in region '$REGION'..."

aws ec2 create-key-pair \
  --region "$REGION" \
  --key-name "$KEY_NAME" \
  --query "KeyMaterial" \
  --output text > "$KEY_DIR/$KEY_NAME.pem"

if [ $? -ne 0 ]; then
  echo "❌ Failed to create key pair"
  exit 1
fi

chmod 400 "$KEY_DIR/$KEY_NAME.pem"

echo "✅ Key pair created successfully"
echo "🔐 Private key saved at: $KEY_DIR/$KEY_NAME.pem"
