**Project Architecture**

<img width="1017" height="693" alt="image" src="https://github.com/user-attachments/assets/52175126-e819-450a-aa88-db54f533cd65" />

### About the Project

This example demonstrates how to create a VPC that you can use for servers in a
production environment.

To improve resiliency, you deploy the servers in two Availability Zones, by using an Auto Scaling group and an Application Load Balancer. For additional security, you deploy the servers in private subnets. The servers receive requests through the load balancer. The servers can connect to the internet by using a NAT gateway. To improve resiliency, you deploy the NAT gateway in both Availability Zones.

### Overview

The VPC has public subnets and private subnets in two Availability Zones. Each public subnet contains a NAT gateway and a load balancer node.

The servers run in the private subnets, are launched and terminated by using an Auto Scaling group, and receive traffic from the load balancer.

The servers can connect to the internet by using the NAT gateway.

### Before we start

Before we start

- Auto Scaling Group
- Load Balancer
- Target Group
- Bastion Host or Jump Server   - Used to connect to EC2 instance which is present in the Private Subnet, as this EC2 don't have Public IP to access it.

---

### Steps

#### High level

1. Create VPC
2. Create ASG
3. Create Bastion Host
4. Install the python application in one EC2 server

1. Create a VPC
    - Name: aws-prod-example
    - IPV6: No
    - AZ: 2
    - Public and Private subnet: 2
    - NAT Gateway: 1 per AZ
    - VPC endpoint for S3 - None
    - Now create a VPC

<img width="1918" height="833" alt="image" src="https://github.com/user-attachments/assets/0e636fcd-14bb-4efc-96e7-e05e29b727bc" />

---
  
2. Create AutoScaling Group

    Navigation: EC2 --> ASG --> Create ASG --> Then Create Launch template

**Launch template**
- Name: aws-prod-LT
- Description: poc for app deploy in aws private subnet
- AMI: Ubuntu configuration
- Instance type: t2.micro
- Keyvalue pair: use your
- SG: create new
     - Name: aws-prod-sg
     - Description: allow ssh access
     - Add rules, Allow inbound for port 22 from anywhere and for our application port 8000 from anywhere
     - Now click create a LT

VPC option will come only if you enable new SG button

<img width="1290" height="763" alt="image" src="https://github.com/user-attachments/assets/fc34959d-e140-4cf3-abf3-bc69cfa1815b" />


Launch Template Created

<img width="1919" height="336" alt="image" src="https://github.com/user-attachments/assets/b39dcb13-872c-463f-b367-2443d4d5a566" />

   
**Create ASG**

- ASG Name: aws-prod-asg
- Select the LT which we created and click next
- Choose the VPC which we created
- AZ: EC2 instance should get created on private subnet, so choose both zone private subnet ( a and b )
- LB: No
- Click next
- Desired: 2 , Minimum: 1, Max: 4
- Scaling policies: None
- Select Next ... and create the ASG


We can see ASG is created and EC2 created by ASG automatically

<img width="1919" height="419" alt="image" src="https://github.com/user-attachments/assets/0eddcbf6-f596-402f-bf8f-9e82a584e703" />
<img width="1902" height="311" alt="image" src="https://github.com/user-attachments/assets/b872c7f0-3435-4936-9dc3-6a0e8d566e17" />

Also we can see, no publich ip assigned as we created this ec2 in private subnet. so we will be creating a bastion host to access these EC2 instances

<img width="1919" height="642" alt="image" src="https://github.com/user-attachments/assets/9d3d18ff-7082-4538-9f97-0f7e8308161a" />



Check the **Subnet ID** of EC2, it will be created on both AZ ( 1a and 1b )

---

3. Create Bastion Host

- Name: Bastion-host
- AMI: Ubuntu
- Keypair: my keypair
- Use your VPC and create a new SG, make sure it allows ssh port 22
- Autoassign public ip: enable
- Launch the instance
- Now copy the pem file from your local lap to bastion host

```bash
scp -i <key.pem> <source> <destination>
scp -i /mnt/e/WSL/AWS/EC2/first-ec2.pem /mnt/e/WSL/AWS/EC2/first-ec2.pem ubuntu@15.207.116.64:/home/ubuntu
```

- Now try connecting from bastion host to private EC2 instance

```bash
ssh -i first-ec2.pem ubuntu@<private-ip>
```

---

4. Install python and create html file

- Python3 already installed in EC2 by default

[html-basic](https://www.w3schools.com/html/html_basic.asp)

```bash
# python
vi index.html -> paste the contents from

# Run the python application
python3 -m http.server 8000
```
