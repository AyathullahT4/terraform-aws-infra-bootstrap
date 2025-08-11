## Terraform AWS Infrastructure Bootstrap

This repository contains reusable Terraform configurations for provisioning AWS infrastructure components, including:

- **EC2 Instance** running NGINX
- **Application Load Balancer (ALB)** fronting an **Auto Scaling Group (ASG)** of NGINX instances
- **S3 backend** for Terraform remote state storage
- **DynamoDB table** for state locking

---

## 📦 Project Structure


```
├── main.tf # Root Terraform config, invokes modules
├── variables.tf # Root variables
├── terraform.tfvars # Variable values (customized for environment)
├── provider.tf # AWS provider & backend configuration
├── outputs.tf # Root output values
├── modules
│ ├── ec2-nginx
│ │ ├── main.tf # Provisions a single EC2 instance with NGINX
│ │ ├── variables.tf
│ │ ├── outputs.tf
│ │ └── user_data.sh # EC2 bootstrap script for NGINX
│ └── alb-asg
│ ├── main.tf # ALB + Target Group + Auto Scaling Group
│ ├── variables.tf
│ ├── outputs.tf
│ └── user_data.sh # ASG instance bootstrap script for NGINX
```

---

## 🚀 What This Deploys

### **Module 1: EC2-NGINX**
- Creates a key pair in AWS using your local public key.
- Launches an Amazon Linux 2023 EC2 instance.
- Installs and starts NGINX via `user_data.sh`.
- Tags the instance with your `instance_name`.

### **Module 2: ALB-ASG**
- Creates an Application Load Balancer (public).
- Creates a Target Group listening on port 80.
- Creates an Auto Scaling Group (min 1, desired 2, max 3 instances).
- Uses a Launch Template to deploy NGINX with the same bootstrap script.

---

## ⚙️ Prerequisites

Before running Terraform:
1. **AWS CLI configured** with `aws configure`  
2. **S3 bucket** for state storage (versioning enabled):
   ```
   aws s3api create-bucket \
     --bucket terraform-bootstrap-state-25 \
     --region us-east-1

   aws s3api put-bucket-versioning \
     --bucket terraform-bootstrap-state-25 \
     --versioning-configuration Status=Enabled

    DynamoDB table for state locking:

    aws dynamodb create-table \
      --table-name terraform-locks \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --billing-mode PAY_PER_REQUEST
    ```

📋 Configuration

Edit terraform.tfvars to match the environment:

instance_name           = "nginx-bootstrap-instance"
instance_type           = "t2.micro"
aws_key_name            = "EC2KeyPair_TF_Managed"
public_key_path         = "~/.ssh/id_rsa.pub"
vpc_security_group_ids  = ["sg-xxxxxxxx"]
subnet_id               = "subnet-xxxxxxxx"
ami_id                  = "ami-xxxxxxxx"  # Amazon Linux 2023
alb_sg_id               = "sg-xxxxxxxx"
subnet_ids              = ["subnet-xxxxxx1", "subnet-xxxxxx2"]
vpc_id                  = "vpc-xxxxxxxx"

🛠️ Deployment Steps

# 1. Initialize Terraform
```
terraform init
```

# 2. Review execution plan
```
terraform plan -out=tfplan
```

# 3. Apply changes
```
terraform apply tfplan
```

# 4. Output results
```
terraform output
```

📜 Outputs

    instance_public_ip → Public IP of the standalone EC2 NGINX instance.

    alb_dns_name → DNS name of the Application Load Balancer.

🗑️ Clean Up

To destroy all resources:
```
terraform destroy
```

🔑 Key Takeaways

    Remote State & Locking → S3 + DynamoDB ensures collaboration safety.

    Modular Approach → Separate EC2 and ALB-ASG for flexibility.

    Bootstrap Automation → All NGINX setup is handled by user_data.sh.

    Customizable Infrastructure → Easily swap AMIs, instance sizes, or scaling settings.

