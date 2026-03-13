Here is a **very small CloudFormation template** you can use to **demonstrate drift easily** with an S3 bucket.

It creates a bucket **without versioning**. Then you will manually enable versioning to create drift.

Service involved:

* AWS CloudFormation
* Amazon S3

---

# 1️⃣ CloudFormation Template (drift-demo.yaml)

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Description: Simple stack to demonstrate CloudFormation drift

Resources:
  DriftDemoBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: drift-demo-bucket-sesha-001
      Tags:
        - Key: Owner
          Value: Demo
```

⚠️ Bucket name must be **globally unique**, so change if needed.

---

# 2️⃣ Deploy the Stack

```bash
aws cloudformation create-stack \
--stack-name drift-demo-stack \
--template-body file://drift-demo.yaml \
--region ap-south-1
```

Wait until stack status becomes:

```
CREATE_COMPLETE
```

---

# 3️⃣ Create Drift (Manual Change)

Go to **S3 console**

```
S3
 → drift-demo-bucket-sesha-001
 → Properties
 → Bucket Versioning
 → Enable
```

CloudFormation **did not define versioning**, so this creates **configuration drift**.

---

# 4️⃣ Run Drift Detection

In **CloudFormation console**

```
Stacks
 → drift-demo-stack
 → Stack actions
 → Detect drift
```

After ~30 seconds check:

```
Drift status: DRIFTED
```

Resource status:

```
DriftDemoBucket → MODIFIED
```

---

# 5️⃣ Show Drift Details

Click the bucket resource → **View drift details**

Example output:

```
Property: VersioningConfiguration
Expected: Disabled
Actual: Enabled
```

---

# 6️⃣ Good Explanation for Demo / Interview

You can say:

> Drift occurs when a resource created by CloudFormation is modified outside the stack. CloudFormation drift detection helps identify configuration differences between the stack template and the actual resource state.

---

# ⭐ Bonus (Cool Demo Trick)

Another easy drift you can show:

Manually add a **tag** to the bucket:

```
Key: Environment
Value: Test
```

Drift detection will show:

```
Tags → MODIFIED
```

---

✅ If you want, I can also show **a very cool DevOps interview demo** where we create drift **using AWS CLI instead of the console** (looks much more impressive).


After you detect drift in your stack created with AWS CloudFormation for the Amazon S3 bucket, **CloudFormation cannot automatically “fix” drift with one button**. You must **bring the actual resource state back to what the template defines** or **update the template to match the new state**.

There are **two practical ways to fix it**.

---

# 1️⃣ Revert the Manual Change (Restore to Template State)

If your template **did not include versioning**, but you manually enabled it, you must **disable it again**.

### Using Console

```
S3 Console
 → Bucket
 → Properties
 → Bucket Versioning
 → Suspend
```

Then run **Drift Detection again**.

Result should become:

```
Stack Drift Status: IN_SYNC
```

---

### Using AWS CLI

```bash
aws s3api put-bucket-versioning \
--bucket drift-demo-bucket-sesha-001 \
--versioning-configuration Status=Suspended
```

Then detect drift again:

```bash
aws cloudformation detect-stack-drift \
--stack-name drift-demo-stack
```

---

# 2️⃣ Update the Template to Match the Actual State

If you **want versioning enabled permanently**, modify your CloudFormation template.

### Updated Template

```yaml
Resources:
  DriftDemoBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: drift-demo-bucket-sesha-001
      VersioningConfiguration:
        Status: Enabled
```

Then update stack:

```bash
aws cloudformation update-stack \
--stack-name drift-demo-stack \
--template-body file://drift-demo.yaml
```

Now the stack will become **IN_SYNC**.

---

# 3️⃣ How to Demonstrate in Interview / Demo

Nice flow:

1️⃣ Create stack (bucket without versioning)
2️⃣ Enable versioning manually in S3
3️⃣ Run drift detection → **DRIFTED**
4️⃣ Fix drift by updating stack template
5️⃣ Run drift detection again → **IN_SYNC**

This clearly shows **Infrastructure as Code governance**.


🔑 Key Concept (important for interviews)

In AWS CloudFormation:

Drift detection only identifies configuration differences

Remediation requires a stack update

CloudFormation does not automatically correct drift

---

✅ **Pro DevOps Tip:**
Drift usually happens when engineers **modify resources directly in the console instead of through CloudFormation/Terraform**. In production environments, teams often enforce **IaC-only changes** to avoid drift.

---

If you want, I can also show **one powerful CloudFormation drift demo using Security Groups** which shows drift **much more clearly than S3 buckets**.
