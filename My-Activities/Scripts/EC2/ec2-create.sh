aws ec2 run-instances \
  --image-id ami-051a31ab2f4d498f5 \
  --instance-type t2.micro \
  --key-name first-ec2 \
  --count 1 \
  --block-device-mappings '[{"DeviceName":"/dev/xvda","Ebs":{"VolumeSize":8,"VolumeType":"gp2","DeleteOnTermination":true}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=first-ec2}]'
