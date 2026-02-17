### Cli-installation on Ubuntu

[doc](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

```


# Method1: AWS Login

- Open aws cli terminal and type below command

```bash
aws login                                                  # login
region: ap-south-1                                         # Set the region

# Then it will ask for authentication in browser, so we need to authenticate


root@LAPTOP-QMBUJPPJ:~/.aws# aws sts get-caller-identity    # used to validate the current user
{
    "UserId": "AIDAWZIMWT5LJUEZ7I7ME",
    "Account": "466567470934",
    "Arn": "arn:aws:iam::466567470934:user/sesha-write"

```

<img width="1919" height="351" alt="image" src="https://github.com/user-attachments/assets/f581abfc-fda2-4ac4-899b-209cf7b0eb63" />


<img width="1916" height="719" alt="image" src="https://github.com/user-attachments/assets/dfa5de17-9a61-4a64-908d-be872f74cc57" />

<img width="1919" height="382" alt="image" src="https://github.com/user-attachments/assets/453c775b-b08a-45ff-8ad1-5f8ca2851baf" />

