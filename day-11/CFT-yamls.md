
- Create a S3 bucket using below yaml
- CFT -> Choose an existing template --> Sync from git
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: S3 Bucket

Resources:
  MyS3Bucket:
    Type: AWS::S3::Bucket
```
