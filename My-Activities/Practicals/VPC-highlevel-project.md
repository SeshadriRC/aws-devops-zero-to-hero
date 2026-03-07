**Project Architecture**

<img width="1017" height="693" alt="image" src="https://github.com/user-attachments/assets/52175126-e819-450a-aa88-db54f533cd65" />

### About the Project

This example demonstrates how to create a VPC that you can use for servers in a
production environment.

To improve resiliency, you deploy the servers in two Availability Zones, by using an Auto Scaling group and an Application Load Balancer. For additional security, you deploy the servers in private subnets. The servers receive requests through the load balancer. The servers can connect to the internet by using a NAT gateway. To improve resiliency, you deploy the NAT gateway in both Availability Zones.
