**OIDC (OpenID Connect)** is a simple way to **log in to one system using another trusted account**.

## 🧠 Simple definition

👉 OIDC = **Login using an identity provider**

Example:

* Login to an app using Google
* Login to AWS using SSO

## 🔑 Real-world analogy

Think of it like this:

* You go to a hotel 🏨
* Instead of creating a new ID, you show your Aadhaar/passport
* Hotel trusts it and gives you access

👉 That Aadhaar = OIDC identity provider

## ⚙️ How it works (very simple)

1. You try to log in to an app
2. App redirects you to an identity provider (like Google or Amazon Web Services)
3. You log in there
4. You get a **token (ID token)**
5. App trusts the token and logs you in


## 📦 Key components

* **User** → you
* **Client** → app (website / AWS / Kubernetes)
* **Identity Provider (IdP)** → Google, AWS, Okta
* **Token** → proof you are authenticated


## 🚀 Example in your DevOps world

### 🔹 In AWS EKS

OIDC is used for:

* Pods accessing AWS services securely

👉 Instead of storing credentials:

* Pod gets a **temporary token**
* AWS trusts it via OIDC

### 🔹 Example flow

* Pod → requests access to S3
* AWS checks OIDC token
* If valid → access granted ✅


## 🔐 Why OIDC is important

* No hardcoded passwords ❌
* Secure token-based access ✅
* Used everywhere:

  * Kubernetes
  * AWS IAM Roles for Service Accounts (IRSA)
  * SSO logins


## 🧠 One-line memory trick

👉 **OIDC = “Login using another trusted identity”**


---

# commands to configure IAM OIDC provider 

```
export cluster_name=demo-cluster
```

```
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5) 
```

## Check if there is an IAM OIDC provider configured already

```
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```

<img width="762" height="112" alt="image" src="https://github.com/user-attachments/assets/23275a6e-93be-45e9-a16f-55b261eca449" />


If not, run the below command

```
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

<img width="1019" height="181" alt="image" src="https://github.com/user-attachments/assets/757b19a0-310c-42e0-9cfe-777380149b6b" />


