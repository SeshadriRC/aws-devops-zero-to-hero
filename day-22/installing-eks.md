# Install EKS

Please follow the prerequisites doc before this.

## Install using Fargate

- It taken 17 minutes to install

```
eksctl create cluster --name demo-cluster --region ap-south-1 --fargate
```

## Delete the cluster

- It taken 18 minutes to delete

```
eksctl delete cluster --name demo-cluster --region ap-south-1
```

- i got a below error like this, so i just deleted LB manually, then triggered delete command again

<img width="1369" height="634" alt="image" src="https://github.com/user-attachments/assets/5a604dff-f359-4e31-9727-97f7aaf7a3c2" />


