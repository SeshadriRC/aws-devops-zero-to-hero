# Introduction to AWS ECR (Elastic Container Registry)

In this video, we will deep dive into the fundamental concepts of ECR and provide you with a step-by-step practical guide on how to use it effectively. So, let's get started!

## Table of Contents
1. What is AWS ECR?
2. Key Benefits of ECR
3. Getting Started with AWS ECR
   - Creating an ECR Repository
   - Installing AWS CLI
   - Configuring AWS CLI
4. Pushing Docker Images to ECR
5. Pulling Docker Images from ECR
6. Cleaning Up Resources

## 1. What is AWS ECR?
AWS Elastic Container Registry (ECR) is a fully managed container image registry service provided by Amazon Web Services (AWS). It enables you to store, manage, and deploy container images (Docker images) securely, making it an essential component of your containerized application development workflow. ECR integrates seamlessly with other AWS services like Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS).

## 2. Key Benefits of ECR
- **Security**: ECR offers encryption at rest, and images are stored in private repositories by default, ensuring the security of your container images.
- **Integration**: ECR integrates smoothly with AWS services like ECS and EKS, simplifying the deployment process.
- **Scalability**: As a managed service, ECR automatically scales to meet the demands of your container image storage.
- **Availability**: ECR guarantees high availability, reducing the risk of image unavailability during critical times.
- **Lifecycle Policies**: You can define lifecycle policies to automate the cleanup of unused or old container images, helping you save on storage costs.

## 3. Getting Started with AWS ECR
### Creating an ECR Repository
1. Go to the AWS Management Console and navigate to the Amazon ECR service.
2. Click on "Create repository" to create a new repository.
3. Enter a unique name for your repository and click "Create repository."

### Installing AWS CLI
To interact with ECR from your local machine, you'll need to have the AWS Command Line Interface (CLI) installed. Follow the instructions in the [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) to install it.

### Configuring AWS CLI
After installing the AWS CLI, open a terminal and run the following command to configure your CLI with your AWS credentials:

```
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region, and preferred output format when prompted.

## 4. Pushing Docker Images to ECR
Now that you have your ECR repository set up and the AWS CLI configured, let's push a Docker image to ECR.

1. Build your Docker image locally using the `docker build` command:

```
docker build -t <your-image-name> <path-to-dockerfile>

Example:
root@LAPTOP-QMBUJPPJ:~# cat Dockerfile
FROM ubuntu:latest
root@LAPTOP-QMBUJPPJ:~# docker build -t myfirst-image .

root@LAPTOP-QMBUJPPJ:~# docker images
REPOSITORY      TAG       IMAGE ID       CREATED       SIZE
myfirst-image   latest    f794f40ddfff   4 weeks ago   78.1MB
```

2. Tag the image with your ECR repository URI:

```
docker tag <your-image-name>:<tag> <your-aws-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-repository-name>:<tag>

Example:
docker tag myfirst-image:latest 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest

REPOSITORY                                                    TAG       IMAGE ID       CREATED       SIZE
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   latest    f794f40ddfff   4 weeks ago   78.1MB
```

3. Log in to your ECR registry using the AWS CLI:

```
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-aws-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

4. Push the Docker image to ECR:

```
docker push <your-aws-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-repository-name>:<tag>

docker push 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
```
<img width="1919" height="494" alt="image" src="https://github.com/user-attachments/assets/79b2a7af-77e5-4cbe-ad43-506602a77c2b" />

<img width="1782" height="301" alt="image" src="https://github.com/user-attachments/assets/420799ee-4f60-42bf-8f03-ee796b2b999c" />


## 5. Pulling Docker Images from ECR
To pull and use the Docker images from ECR on another system or AWS service, follow these steps:

1. Log in to ECR using the AWS CLI as shown in Step 3 of the previous section.
2. Pull the Docker image from ECR:

```
docker pull <your-aws-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-repository-name>:<tag>
```

```bash
root@LAPTOP-QMBUJPPJ:~# docker pull 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
latest: Pulling from demo-app-repo
18dbadc1f2f9: Pull complete
Digest: sha256:69426aeccf94f0b8876e114982963a979f0205bd84d959eff7ab1982928846ea
Status: Downloaded newer image for 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest

root@LAPTOP-QMBUJPPJ:~# docker images
REPOSITORY                                                    TAG       IMAGE ID       CREATED       SIZE
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   latest    f794f40ddfff   4 weeks ago   78.1MB

root@LAPTOP-QMBUJPPJ:~# docker pull 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:v2
v2: Pulling from demo-app-repo
Digest: sha256:69426aeccf94f0b8876e114982963a979f0205bd84d959eff7ab1982928846ea
Status: Downloaded newer image for 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:v2
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:v2

root@LAPTOP-QMBUJPPJ:~# docker images
REPOSITORY                                                    TAG       IMAGE ID       CREATED       SIZE
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   latest    f794f40ddfff   4 weeks ago   78.1MB
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   v2        f794f40ddfff   4 weeks ago   78.1MB
```


## 6. Cleaning Up Resources
As good practice, remember to clean up resources that you no longer need to avoid unnecessary costs. To delete an ECR repository:

1. Make sure there are no images in the repository, or delete the images using `docker rmi` locally.

```bash
root@LAPTOP-QMBUJPPJ:~# docker images
REPOSITORY                                                    TAG       IMAGE ID       CREATED       SIZE
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   latest    f794f40ddfff   4 weeks ago   78.1MB
466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo   v2        f794f40ddfff   4 weeks ago   78.1MB
myfirst-image                                                 latest    f794f40ddfff   4 weeks ago   78.1MB
ubuntu                                                        latest    f794f40ddfff   4 weeks ago   78.1MB

root@LAPTOP-QMBUJPPJ:~# docker rmi f79
Error response from daemon: conflict: unable to delete f794f40ddfff (must be forced) - image is referenced in multiple repositories
root@LAPTOP-QMBUJPPJ:~# docker rmi -f f79
Untagged: 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:latest
Untagged: 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo:v2
Untagged: 466567470934.dkr.ecr.ap-south-1.amazonaws.com/demo-app-repo@sha256:69426aeccf94f0b8876e114982963a979f0205bd84d959eff7ab1982928846ea
Untagged: myfirst-image:latest
Untagged: ubuntu:latest
Untagged: ubuntu@sha256:186072bba1b2f436cbb91ef2567abca677337cfc786c86e107d25b7072feef0c
Deleted: sha256:f794f40ddfff5af8ef1b39ee29eab3b5400ea70b9ebefd286812dbbe0054ad6b
Deleted: sha256:f2a7f072635332d307212e318e07284948b89f4167fce5c4d7c9cfb7590b74b6

root@LAPTOP-QMBUJPPJ:~# docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```

<img width="1905" height="457" alt="image" src="https://github.com/user-attachments/assets/953386e6-7efe-4f9d-8e04-fd28d3490aab" />


3. Go to the AWS Management Console, navigate to the Amazon ECR service, and select your repository.
4. Click on "Delete" and confirm the action.

## I Created a separate user

<img width="1919" height="181" alt="image" src="https://github.com/user-attachments/assets/20c8d5d9-8e90-4550-949a-a31afa824e24" />

- Attach the below policy to the user using root account.

<img width="1918" height="918" alt="image" src="https://github.com/user-attachments/assets/460432ee-841d-4f90-81d2-96062afc7be6" />

- Now try login again, it will get succeeded.

<img width="1890" height="212" alt="image" src="https://github.com/user-attachments/assets/84cc2d77-3675-42f5-96f5-be8688ca530c" />

<img width="1472" height="237" alt="image" src="https://github.com/user-attachments/assets/60753a51-a43d-4e55-9178-a34271d394e1" />



---



---
