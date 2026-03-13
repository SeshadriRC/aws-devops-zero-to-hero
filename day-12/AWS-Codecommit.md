- Overview of CodeCommit
- Advantages of Codecommit
- Create a demo repo
- Upload a sample file in the repo
- Create a sample IAM user for this codecommit purpose
- Need to install git, i haven't installed since im using gitbash
- Clone the repo
- Now perform git add, commit, push


---

- Overview of Codecommit

<img width="1731" height="468" alt="image" src="https://github.com/user-attachments/assets/54bd225c-7dcb-4eea-8b61-4a0147d73090" />

  - AWS provides a comprehensive set of CI/CD (Continuous Integration/Continuous Deployment) services that enable developers to automate and streamline their
software delivery processes.
  - AWS CodePipeline, AWS CodeBuild, and AWS CodeDeploy are the key services involved in achieving CI/CD on AWS platform.

---
**Advantages**

- Managed Git
- Scalability
- Reliability

---

**Disadvantages**

- Features
- AWS Restricted
- Less integrations with services outside AWS
---

- Below is the Codecommit service

<img width="1919" height="750" alt="image" src="https://github.com/user-attachments/assets/8ccffc30-9074-4b61-aaa1-e9960d2572c5" />

---

- Create a Demo repo, no need to enable cloudguru
- Also we should not use root account for Codecommit, as it won't work properly for this service

<img width="1902" height="847" alt="image" src="https://github.com/user-attachments/assets/39c506f7-5244-434f-a6f9-b615991e8f9b" />

<img width="1919" height="868" alt="image" src="https://github.com/user-attachments/assets/d88c03c2-5ad0-4b71-ae6c-6c8fce4a222a" />

---

- Upload a Sample file

<img width="1910" height="775" alt="image" src="https://github.com/user-attachments/assets/9b4d10b1-da10-4bcf-8a82-30ccd8a5a4ef" />

- Only one file we can able to do it in UI, whereas in git terminal mulitple files we can push

<img width="1919" height="836" alt="image" src="https://github.com/user-attachments/assets/f99874df-5969-4781-9ba9-404200b03c62" />

---
- Create a sample IAM user for this codecommit purpose

<img width="1903" height="830" alt="image" src="https://github.com/user-attachments/assets/11552325-8012-4581-8749-2439d4c5c93b" />
<img width="1919" height="814" alt="image" src="https://github.com/user-attachments/assets/ad3da4d1-0f6c-47ad-8313-3176f6b8a6a6" />


IAM → Users → cc-user → Security credentials

Scroll to:

HTTPS Git credentials for AWS CodeCommit

<img width="1896" height="757" alt="image" src="https://github.com/user-attachments/assets/1a6d24f2-2893-49e9-b1dc-63a588ed4107" />
<img width="1545" height="262" alt="image" src="https://github.com/user-attachments/assets/98fbefb3-99e1-4ba7-bc9c-54e4883ad37d" />


---

- Clone the repo(clone https), it will ask for creds so input the creds which we created above

username: cc-user-at-466567470934

password: as per that cred

<img width="1715" height="359" alt="image" src="https://github.com/user-attachments/assets/2681b7ce-2223-456d-86cb-247645d3c018" />



---

- Perform git operations like git add, commit, push. we can see new file got pushed to the repo

<img width="1914" height="585" alt="image" src="https://github.com/user-attachments/assets/3f1a9acb-a646-4fc1-894a-d220147883ae" />

---
