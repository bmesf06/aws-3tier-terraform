# AWS 3-Tier Core Network Architecture (Automated via Terraform)

This project outlines a resilient 3-tier AWS application using Terraform for Infrastructure as Code (IaC), focusing on secure, isolated networking. The architecture features a public ALB, private EC2 web servers, and isolated MySQL RDS instances, with an S3 bucket for storage.

## ??? The Technical Breakdown & Engineering Decisions

1.  **Public Ingress Tier**: Application Load Balancer (ALB) manages public traffic in public subnets.
2.  **Quarantined Compute Tier**: EC2 instances in private subnets with no public IPs, accessed only via ALB.
3.  **Isolated Database Tier**: MySQL RDS in private subnets, allowing traffic only from the app tier security group.
4.  **Security & Monitoring**: Security group chaining (preventing lateral movement) and CloudWatch metrics.

## ?? CI/CD & Validation
Includes GitHub Actions for `terraform fmt` and `terraform validate` to ensure code quality, as seen in.

## ?? How to Spin It Up
Run `terraform init`, `plan`, and `apply` in the `infra/` directory.
