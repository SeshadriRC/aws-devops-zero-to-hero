### Cli-installation on Ubuntu

[doc](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

```


# Method-1: AWS Login      

```However Method-2 is recommended```

- Open aws cli terminal and type below command

```bash
aws login                                                  # login
region: ap-south-1                                         # Set the region

# Then it will ask for authentication in browser, so we need to authenticate
```

<img width="1919" height="351" alt="image" src="https://github.com/user-attachments/assets/f581abfc-fda2-4ac4-899b-209cf7b0eb63" />


<img width="1916" height="719" alt="image" src="https://github.com/user-attachments/assets/dfa5de17-9a61-4a64-908d-be872f74cc57" />

<img width="1919" height="382" alt="image" src="https://github.com/user-attachments/assets/453c775b-b08a-45ff-8ad1-5f8ca2851baf" />

```bash
root@LAPTOP-QMBUJPPJ:~/.aws# aws sts get-caller-identity    # used to validate the current user
{
    "UserId": "AIDAWZIMWT5LJUEZ7I7ME",
    "Account": "466567470934",
    "Arn": "arn:aws:iam::466567470934:user/sesha-write"

root@LAPTOP-QMBUJPPJ:~/.aws# aws configure get region
ap-south-1

root@LAPTOP-QMBUJPPJ:~/.aws# aws configure list
NAME       : VALUE                    : TYPE             : LOCATION
profile    : <not set>                : None             : None
access_key : ****************LHAN     : login            :
secret_key : ****************JywS     : login            :
region     : ap-south-1               : config-file      : ~/.aws/config

```

---

# Method-2: Access Key --> Recommended

```
IAM → Users → sesha-write → Security credentials → Create access key
```

<img width="1919" height="583" alt="image" src="https://github.com/user-attachments/assets/2f9cb57f-8f92-4720-9f5c-cd117da5c18d" />
<img width="1916" height="521" alt="image" src="https://github.com/user-attachments/assets/3bd15e4c-1c36-4cef-b62f-b5b6220fb2ab" />
<img width="1919" height="528" alt="image" src="https://github.com/user-attachments/assets/a8e76310-005f-4845-a902-51bf2ef1da5c" />
<img width="1930" height="935" alt="image" src="https://github.com/user-attachments/assets/63e7ed69-020b-40df-9b06-1354d092e369" />





---

## CLI commands

