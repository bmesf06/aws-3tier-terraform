\# AWS 3-Tier Architecture with Terraform





\## Overview



This project deploys a three-tier web application architecture on AWS using Terraform. It includes:



\- Networking: VPC, 2 public and 2 private subnets across 2 AZs, Internet Gateway, routing.

\- Security: Security groups for ALB, web tier, and RDS (tiered access).

\- Compute: EC2 web server in a private subnet with Nginx installed via user data.

\- Load Balancing: Internet-facing Application Load Balancer with target group and HTTP listener.

\- Data: MySQL RDS instance in private subnets, only accessible from the web tier SG.

\- Storage: S3 bucket for logs or static assets.

\- Monitoring: CloudWatch CPU alarm on the web instance.



\## Tech Stack



\- AWS: VPC, EC2, ALB, RDS (MySQL), S3, CloudWatch.

\- Terraform: AWS provider, remote state local.









\## How to Deploy



1\. Clone this repo.

2\. Configure AWS credentials (e.g., via `aws configure`) for a user with permissions to create VPC/EC2/RDS/S3.

3\. From the `infra` directory:



&nbsp;  ```bash

&nbsp;  terraform init

&nbsp;  terraform plan

&nbsp;  terraform apply



```mermaid
graph TD
    %% Define Elements
    Internet((Internet)) --> IGW[Internet Gateway]
    IGW --> ALB[Application Load Balancer]
    
    %% Availability Zone 1
    subgraph AZ1 [Availability Zone: us-east-1a]
        subgraph Pub1 [Public Subnet 10.0.1.0/24]
            ALB
        end
        subgraph Priv1 [Private Subnet 10.0.11.0/24]
            EC2_1[Nginx EC2 Instance 1]
        end
        subgraph DB1 [Database Subnet]
            RDS[(MySQL RDS Primary)]
        end
    end

    %% Availability Zone 2
    subgraph AZ2 [Availability Zone: us-east-1b]
        subgraph Pub2 [Public Subnet 10.0.2.0/24]
            ALB
        end
        subgraph Priv2 [Private Subnet 10.0.12.0/24]
            EC2_2[Nginx EC2 Instance 2]
        end
        subgraph DB2 [Database Subnet]
            RDS
        end
    end

    %% Traffic Routing Connections
    ALB --> EC2_1
    ALB --> EC2_2
    EC2_1 --> RDS
    EC2_2 --> RDS

    %% Styling
    style ALB fill:#a1887f,stroke:#333,stroke-width:2px
    style RDS fill:#90caf9,stroke:#333,stroke-width:2px
    style EC2_1 fill:#fff59d,stroke:#333,stroke-width:1px
    style EC2_2 fill:#fff59d,stroke:#333,stroke-width:1px
```
