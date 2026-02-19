\# AWS 3-Tier Infrastructure as Code (Project 2)



A fully automated 3-tier AWS architecture deployed using Terraform. This project demonstrates high availability, tiered security, and automated resource provisioning.



\## 🏗️ Architecture

\- \*\*Networking:\*\* VPC with 4 subnets (2 Public, 2 Private) across multiple Availability Zones.

\- \*\*Compute:\*\* Private EC2 instance running Nginx via User Data.

\- \*\*Load Balancing:\*\* Internet-facing ALB routing traffic to private targets.

\- \*\*Database:\*\* Managed RDS MySQL instance in a private subnet.

\- \*\*Storage:\*\* S3 Bucket for logs/assets with a unique naming scheme.

\- \*\*Monitoring:\*\* CloudWatch CPU Utilization alarms.



\## 🚀 How to Deploy

1\. Configure AWS Credentials (`aws configure`).

2\. Navigate to the `/infra` directory.

3\. Run `terraform init`.

4\. Run `terraform apply -auto-approve`.



\## 🛠️ Tech Stack

\- Terraform (IaC)

\- AWS (EC2, VPC, RDS, S3, ALB, CloudWatch)

\- Git/GitHub



