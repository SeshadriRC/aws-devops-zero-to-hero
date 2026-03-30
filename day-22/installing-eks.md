# Install EKS

Please follow the prerequisites doc before this.

## Install using Fargate

<img width="1826" height="918" alt="image" src="https://github.com/user-attachments/assets/df014728-d303-4ea4-b86b-f77b5eddc5e9" />


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

<img width="1919" height="440" alt="image" src="https://github.com/user-attachments/assets/c9fac1f4-e4cf-4a60-8aff-e85a3c50e821" />


<img width="1919" height="359" alt="image" src="https://github.com/user-attachments/assets/12ea9305-eb69-4f2d-9c98-7eaff2c1ff7c" />

- vpc only taking time to delete in cloudformation

<img width="1919" height="532" alt="image" src="https://github.com/user-attachments/assets/b04bc5b0-3553-4194-b0cc-09419b2e14c5" />

