aws ec2 describe-key-pairs \
  --query "KeyPairs[].{KeyName:KeyName,KeyPairId:KeyPairId,Type:KeyType,Created:CreateTime}" \
  --output table
