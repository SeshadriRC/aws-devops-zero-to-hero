#!/bin/bash

echo "=========== Delete AWS EC2 Key Pair ==========="

read -p "Enter AWS Region (example: ap-south-1): " REGION
read -p "Enter Key Pair Name to DELETE: " KEY_NAME

if [[ -z "$REGION" || -z "$KEY_NAME" ]]; then
  echo "❌ Region and Key Pair Name cannot be empty"
  exit 1
fi

echo
echo "You are about to DELETE the following key pair:"
echo "Region  : $REGION"
echo "Key Name: $KEY_NAME"
echo

read -p "Type DELETE to confirm: " CONFIRM

if [[ "$CONFIRM" != "DELETE" ]]; then
  echo "❌ Aborted."
  exit 0
fi

echo "🗑️ Deleting key pair '$KEY_NAME'..."

aws ec2 delete-key-pair \
  --region "$REGION" \
  --key-name "$KEY_NAME"

if [[ $? -ne 0 ]]; then
  echo "❌ Failed to delete key pair"
  exit 1
fi

echo "✅ Key pair deleted successfully"

# Optional: delete local pem file
read -p "Do you also want to delete local private key file ($KEY_NAME.pem)? (yes/no): " DEL_LOCAL

if [[ "$DEL_LOCAL" == "yes" ]]; then
  rm -f "$KEY_NAME.pem"
  echo "🗑️ Local private key file removed"
fi
