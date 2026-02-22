- By default its a deny policy, if we want to allow specific traffic, then we need to edit the rule
- TCP connection was already established before you removed the SG rule, and AWS allows existing (ESTABLISHED) connections to continue. This is called stateful connection tracking.
- Instead of using IP address, AWS lets you use another Security Group as source, Any EC2 instance that has this security group attached can access ALL ports of this EC2.
  - testing-sg
<img width="1918" height="878" alt="image" src="https://github.com/user-attachments/assets/8a33f519-fc10-4ce2-9942-55faceec5721" />

  - default-sg
<img width="1906" height="737" alt="image" src="https://github.com/user-attachments/assets/ef358d51-2c54-4306-a7bf-e83605ed4d87" />
