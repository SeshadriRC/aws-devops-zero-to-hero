Note:- First layer of defence is NACL and Second is SG

<img width="1189" height="514" alt="image" src="https://github.com/user-attachments/assets/220d99db-d84c-4f10-91d9-69e57710ad79" />


Practice Steps:
- Create VPC
- Create EC2 and associate the custom VPC
- Run the python app

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


<img width="1315" height="769" alt="image" src="https://github.com/user-attachments/assets/98cdbb8d-9225-438b-88df-97ac6c1cf021" />


- Make sure below option is enabled for public subnet, then only auto assign of public ip will happen

<img width="1919" height="929" alt="image" src="https://github.com/user-attachments/assets/c985b6b9-65b2-462a-9ddf-2870405d38b3" />

- Instance is launched

<img width="1919" height="860" alt="image" src="https://github.com/user-attachments/assets/67034d23-1cf1-49cf-8e75-b8cec0998cd8" />

---

### Run the python app

<img width="1010" height="199" alt="image" src="https://github.com/user-attachments/assets/9e212330-3351-4f08-8457-41a87011078b" />

- you can't able to access it, due to SG

<img width="1919" height="385" alt="image" src="https://github.com/user-attachments/assets/84c1fd78-cbc9-4c6a-96f6-a02151abe2e3" />

- Below is the configuration of NACL and SG

  - Least number will be picked first. Eg: 100 and 200, first 100 will verified post that 200
<img width="1919" height="672" alt="image" src="https://github.com/user-attachments/assets/340c60e5-e010-42ef-ba6d-0f83a90121cb" />

 - so here first level NACL is allowing, but SG is blocking
<img width="1919" height="526" alt="image" src="https://github.com/user-attachments/assets/c2b5bb83-28f1-44b2-a02e-9e9cfaa3510c" />

- Now im able to access it
<img width="1919" height="451" alt="image" src="https://github.com/user-attachments/assets/c0870683-ce88-40b4-8370-a780fffab70b" />
<img width="1919" height="482" alt="image" src="https://github.com/user-attachments/assets/0f0981f9-f66f-42a6-9227-661b937403a8" />

- Now block port 8000 it in NACL level, it won't work now
<img width="1919" height="673" alt="image" src="https://github.com/user-attachments/assets/9861970b-b630-4a2e-a8c6-144cef955498" />
<img width="1521" height="769" alt="image" src="https://github.com/user-attachments/assets/02bfacec-3c2c-41c3-a0b4-13599df8bffd" />









