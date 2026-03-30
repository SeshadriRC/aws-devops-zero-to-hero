# How to setup alb add on

Download IAM policy

```
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
```

Create IAM Policy

```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```
<img width="1287" height="487" alt="image" src="https://github.com/user-attachments/assets/91ce4fcf-4cb8-4b42-b13c-396af69c9229" />


Create IAM Role

```
eksctl create iamserviceaccount \
  --cluster=<your-cluster-name> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<your-aws-account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

# Example
eksctl create iamserviceaccount \
  --cluster=demo-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::466567470934:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```
<img width="1399" height="369" alt="image" src="https://github.com/user-attachments/assets/b38a45f1-5fd7-4606-953d-ced7e6758ca1" />
<img width="1919" height="809" alt="image" src="https://github.com/user-attachments/assets/46ec172f-f499-4e8d-be04-ebba5c6233a8" />
<img width="1919" height="760" alt="image" src="https://github.com/user-attachments/assets/05f2303f-e3d7-45ce-9c57-168059bf9b83" />
<img width="1919" height="692" alt="image" src="https://github.com/user-attachments/assets/e7a9d0ff-9888-480b-abf9-741ce1351c97" />


## Deploy ALB controller

Add helm repo

```
helm repo add eks https://aws.github.io/eks-charts
```

Update the repo

```
helm repo update eks
```

<img width="731" height="291" alt="image" src="https://github.com/user-attachments/assets/9f58746c-0911-4a6a-899b-611fbec5b8d8" />


Install

- vpcid we can find from networking tab of demo-cluster
```
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=<your-cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=<your-region> \
  --set vpcId=<your-vpc-id>

# Example
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=demo-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=ap-south-1 \
  --set vpcId=vpc-09228a6aa888136f8
```

<img width="1718" height="506" alt="image" src="https://github.com/user-attachments/assets/6da662e4-7bed-452f-8fbd-abce2a9106e0" />

- For deleting the created helm release

```
helm delete aws-load-balancer-controller -n kube-system
```

Verify that the deployments are running.

<img width="874" height="147" alt="image" src="https://github.com/user-attachments/assets/7119962e-d690-4d16-9f58-a2796ca9f35c" />


```
kubectl get deployment -n kube-system aws-load-balancer-controller
```
