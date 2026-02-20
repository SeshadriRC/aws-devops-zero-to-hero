aws ec2 describe-volumes \
  --query "Volumes[].{VolumeID:VolumeId,Size:Size,Type:VolumeType,State:State,Name:Tags[?Key=='Name']|[0].Value}" \
  --output table
