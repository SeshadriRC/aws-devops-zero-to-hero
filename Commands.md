
- [SSH](#ssh)
- [VPC](#vpc)
- [Elastic-ip](#elastic-ip)
- [EC2](#ec2)
- [Securitygroup](#SG)
- [key-pair](#key-pair)
- [AMI](#AMI)
- [aws-configure](#aws-configure)
- [EBS](#EBS)

# EBS

```
aws ec2 describe-volumes \
  --region us-east-1 \
  --query "Volumes[*].[VolumeId,Size,VolumeType,State]" \
  --output table
```

```
```

# aws-configure

```
aws configure

~ on ☁️  (us-east-1) ➜  aws configure
AWS Access Key ID [****************3UAI]: 
AWS Secret Access Key [****************jqI8]: 
Default region name [us-east-1]: 
Default output format [None]:

```
```
aws configure list

~ on ☁️  (us-east-1) ➜  aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************3UAI shared-credentials-file    
secret_key     ****************jqI8 shared-credentials-file    
    region                us-east-1      config-file    ~/.aws/config

```
```
aws configure get region

~ on ☁️  (us-east-1) ➜  aws configure get region
us-east-1
```



# AMI

```
aws ec2 describe-images \
  --owners self \
  --query 'Images[*].[ImageId,Name,State,CreationDate]' \
  --output table
```

# Key-Pair

```
aws ec2 describe-key-pairs \
  --region us-east-1 \
  --query 'KeyPairs[*].[KeyName,KeyPairId,KeyFingerprint]' \
  --output table
```

# SG

```
aws ec2 describe-security-groups \
  --query "SecurityGroups[*].[GroupId,GroupName]" \
  --output table
```


# SSH

- How it works (simple)

   - Public key → stored on the EC2 instance
   - Private key (mykey.pem) → stays with you
   - SSH verifies they match

```
ssh -i <private-key> ubuntu@<public-ip>

Eg: ssh -i /downloads/mykey.pem ubuntu@<public-ip>

```

# VPC

```
aws ec2 describe-vpcs --query "Vpcs[].VpcId" --output table

aws ec2 describe-vpcs \
  --query "Vpcs[].{VpcId:VpcId, Name:Tags[?Key=='Name'].Value | [0]}" \
  --output table
```

# Elastic IP

```
aws ec2 describe-addresses --output table
```

# EC2

```bash
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId, Tags[?Key=='Name'].Value | [0]]" \
  --output table

aws ec2 describe-instances \
  --query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType}" \
  --output table

# Describe with subnet details
aws ec2 describe-instances \
--filters "Name=private-dns-name,Values=ip-172-31-64-107.ap-south-1.compute.internal,ip-172-31-8-173.ap-south-1.compute.internal" \
--query "Reservations[].Instances[].{Instance:InstanceId,PrivateIP:PrivateIpAddress,Subnet:SubnetId,VPC:VpcId}" \
--output table

```
