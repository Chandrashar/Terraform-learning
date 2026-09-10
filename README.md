# Terraform-learning

Multi-environment Terraform project that provisions EC2 instances with different configurations per environment.

## Features

- Different environments (`dev`, `qa`, `stg`, `prod`)
- Different AMIs per environment
- Different instance counts per environment
- Separate security groups and key pairs per environment
- Remote-exec provisioner that creates a file on every instance

## Example Output

```hcl
Outputs:

all_ec2_instances = {
  "dev-1" = {
    "instance_id" = "i-049c05507fdf6a954"
    "name"        = "dev-ec2-terra-instance-1"
    "private_ip"  = "172.31.43.93"
    "public_ip"   = "3.16.150.181"
  }
  "prod-1" = {
    "instance_id" = "i-02e79beca3d692855"
    "name"        = "prod-ec2-terra-instance-1"
    "private_ip"  = "172.31.41.56"
    "public_ip"   = "18.223.0.248"
  }
  "prod-2" = {
    "instance_id" = "i-007f74d0bae56ed7b"
    "name"        = "prod-ec2-terra-instance-2"
    "private_ip"  = "172.31.37.118"
    "public_ip"   = "18.227.99.107"
  }
  "prod-3" = {
    "instance_id" = "i-0d7b422a5c122c654"
    "name"        = "prod-ec2-terra-instance-3"
    "private_ip"  = "172.31.46.9"
    "public_ip"   = "18.217.35.215"
  }
  "prod-4" = {
    "instance_id" = "i-087f437e0c2ae927b"
    "name"        = "prod-ec2-terra-instance-4"
    "private_ip"  = "172.31.47.184"
    "public_ip"   = "18.218.188.16"
  }
  "qa-1" = {
    "instance_id" = "i-029de56ac71175f8c"
    "name"        = "qa-ec2-terra-instance-1"
    "private_ip"  = "172.31.39.190"
    "public_ip"   = "3.129.17.45"
  }
  "qa-2" = {
    "instance_id" = "i-04def4311fe0b4dd0"
    "name"        = "qa-ec2-terra-instance-2"
    "private_ip"  = "172.31.34.78"
    "public_ip"   = "18.222.192.253"
  }
  "stg-1" = {
    "instance_id" = "i-0f34071b8f867ea14"
    "name"        = "stg-ec2-terra-instance-1"
    "private_ip"  = "172.31.39.233"
    "public_ip"   = "18.188.27.144"
  }
  "stg-2" = {
    "instance_id" = "i-0b09341cd800b24c1"
    "name"        = "stg-ec2-terra-instance-2"
    "private_ip"  = "172.31.46.123"
    "public_ip"   = "77.112.18.36"
  }
  "stg-3" = {
    "instance_id" = "i-04d76d8d4006ec72a"
    "name"        = "stg-ec2-terra-instance-3"
    "private_ip"  = "172.31.34.51"
    "public_ip"   = "13.58.199.142"
  }
}


## Remote Execution:

admin@ip-172-31-41-56:~$ ls -lah
total 24K
drwx------ 3 admin admin 4.0K Sep 10 21:28 .
drwxr-xr-x 3 root  root  4.0K Sep 10 21:28 ..
-rw-r--r-- 1 admin admin  220 Mar  8  2026 .bash_logout
-rw-r--r-- 1 admin admin 3.5K Mar  8  2026 .bashrc
-rw-r--r-- 1 admin admin  807 Mar  8  2026 .profile
drwx------ 2 admin admin 4.0K Sep 10 21:28 .ssh
-rw-rw-r-- 1 admin admin    0 Sep 10 21:28 prod

admin@ip-172-31-41-56:~$ cat /tmp/chandra-remote-exec.txt
Chandra Sharma
ip-172-31-41-56
Linux ip-172-31-41-56 6.12.74+deb13+1-cloud-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.74-2 (2026-03-08) x86_64 GNU/Linux