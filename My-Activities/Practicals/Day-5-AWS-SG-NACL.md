- Create VPC
- Create EC2 and associate the custom VPC

---

### VPC create 

- Input name, CIDR IP adress, AZ-2, Public/Private subnet - 2, NAT - none

<img width="1916" height="879" alt="image" src="https://github.com/user-attachments/assets/d4ede134-3592-4b33-9ae5-3c14408f36ab" />

<img width="708" height="769" alt="image" src="https://github.com/user-attachments/assets/42a9d202-8905-4af9-8945-e11b861b0c46" />

<img width="1919" height="934" alt="image" src="https://github.com/user-attachments/assets/34c6d819-b90b-4743-a9d2-8b9afb642c18" />

<img width="1919" height="923" alt="image" src="https://github.com/user-attachments/assets/8f86d80b-4e77-462b-adae-f38806650768" />

---

### Create EC2 and associate the custom VPC

- Launch a ubuntu, Here we are selecting EC2 in public subnet, however EC2 in private subnet is best practice. just for this video we are doing in public. Let it create new SG, then we can tweak accordingly


<img width="1254" height="867" alt="image" src="https://github.com/user-attachments/assets/276d5e0a-80b8-44a1-b5b6-04de3c538229" />

- Make sure below option is enabled for public subnet, then only auto assign of public ip will happen

<img width="1919" height="929" alt="image" src="https://github.com/user-attachments/assets/c985b6b9-65b2-462a-9ddf-2870405d38b3" />
