aws ec2 describe-instances \
  --query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" \
  --output table
