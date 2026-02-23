```bash
ssh -i /mnt/e/WSL/AWS/EC2/first-ec2.pem ec2-user@3.7.70.242
ssh -i /mnt/e/WSL/AWS/EC2/first-ec2.pem ubuntu@3.7.70.242
```

```bash
Dir: /mnt/e/WSL/AWS/aws-devops-zero-to-hero/My-Activities
```


### Before resize

```bash
root@ip-172-31-8-173:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       6.8G  5.1G  1.7G  76% /
tmpfs           478M     0  478M   0% /dev/shm
tmpfs           191M  900K  191M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda16     881M  156M  663M  20% /boot
/dev/xvda15     105M  6.2M   99M   6% /boot/efi
tmpfs            96M   16K   96M   1% /run/user/1000

root@ip-172-31-8-173:~# lsblk
NAME     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0      7:0    0   74M  1 loop /snap/core22/2163
loop1      7:1    0 27.6M  1 loop /snap/amazon-ssm-agent/11797
loop2      7:2    0 27.8M  1 loop /snap/amazon-ssm-agent/12322
loop3      7:3    0 48.1M  1 loop /snap/snapd/25935
loop4      7:4    0   74M  1 loop /snap/core22/2292
loop5      7:5    0 50.9M  1 loop /snap/snapd/25577
xvda     202:0    0    9G  0 disk
├─xvda1  202:1    0    7G  0 part /
├─xvda14 202:14   0    4M  0 part
├─xvda15 202:15   0  106M  0 part /boot/efi
└─xvda16 259:0    0  913M  0 part /boot
```


### After resize

root@ip-172-31-8-173:~# growpart /dev/xvda 1
CHANGED: partition=1 start=2099200 old: size=14677983 end=16777182 new: size=16775135 end=18874334
root@ip-172-31-8-173:~# lsblk
NAME     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0      7:0    0   74M  1 loop /snap/core22/2163
loop1      7:1    0 27.6M  1 loop /snap/amazon-ssm-agent/11797
loop2      7:2    0 27.8M  1 loop /snap/amazon-ssm-agent/12322
loop3      7:3    0 48.1M  1 loop /snap/snapd/25935
loop4      7:4    0   74M  1 loop /snap/core22/2292
loop5      7:5    0 50.9M  1 loop /snap/snapd/25577
xvda     202:0    0    9G  0 disk
├─xvda1  202:1    0    8G  0 part /
├─xvda14 202:14   0    4M  0 part
├─xvda15 202:15   0  106M  0 part /boot/efi
└─xvda16 259:0    0  913M  0 part /boot
root@ip-172-31-8-173:~# df -T /
Filesystem     Type 1K-blocks    Used Available Use% Mounted on
/dev/root      ext4   7034376 5326112   1691880  76% /
root@ip-172-31-8-173:~# resize2fs /dev/xvda1
resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/xvda1 is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/xvda1 is now 2096891 (4k) blocks long.

root@ip-172-31-8-173:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.7G  5.1G  2.6G  67% /
tmpfs           478M     0  478M   0% /dev/shm
tmpfs           191M  900K  191M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda16     881M  156M  663M  20% /boot
/dev/xvda15     105M  6.2M   99M   6% /boot/efi
tmpfs            96M   16K   96M   1% /run/user/1000
root@ip-172-31-8-173:~#


This is **expected behavior** 👍 — you resized the **EBS volume**, but the **Linux partition and filesystem are still using the old size**. You now need to **extend the partition + filesystem**.

Let’s fix it cleanly.

---

# What happened?

From your output:

```text
Disk xvda size  → 9G   ✅  (AWS resize worked)
Root partition  → 7G   ❌  (still old size)
Filesystem (/)  → 6.8G ❌  (still old size)
```

So:

* AWS increased the disk ✔
* Linux **did not auto-expand partition + filesystem** ❌

---

# Correct Fix (Ubuntu / Debian on EC2)

Your root disk:

```text
Disk: /dev/xvda
Root partition: /dev/xvda1
```

We must:

1. Grow the partition
2. Grow the filesystem

---

# Step 1 — Install growpart (if not present)

```bash
sudo apt update
sudo apt install -y cloud-guest-utils
```

---

# Step 2 — Expand the partition

```bash
sudo growpart /dev/xvda 1
```

Expected output:

```text
CHANGED: partition=1 start=... old: size=... new: size=...
```

---

# Step 3 — Resize filesystem

Check filesystem type:

```bash
df -T /
```

If filesystem is **ext4** (most Ubuntu AMIs):

```bash
sudo resize2fs /dev/xvda1
```

If filesystem is **xfs** (Amazon Linux / RHEL / CentOS):

```bash
sudo xfs_growfs /
```

---

# Step 4 — Verify

```bash
df -h
```

You should now see:

```text
/dev/root   ~8.8G   ...
```

---

# Why AWS doesn't auto-expand Linux filesystem?

Because:

* AWS resizes **block device only**
* OS-level partition + filesystem resizing is **your responsibility**

This is **standard behavior in all clouds**.

---

# One-command method (Ubuntu EC2 only)

If you want **fully automatic resize**:

```bash
sudo growpart /dev/xvda 1 && sudo resize2fs /dev/xvda1
```

---

# For your learning (important)

Flow is always:

```text
AWS volume resize
        ↓
Linux partition resize
        ↓
Filesystem resize
```

---

If your instance was **LVM-based**, steps differ — but yours is **simple partition-based**, so above is correct.

---

If you want, I can also show:

* LVM resize method
* XFS filesystem resize
* Live resize without reboot
* Terraform auto-grow automation

Just say 😄

