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
graph LR
    %% Define Root Infrastructure Layer
    Internet((Internet)) --> IGW[Internet Gateway]
    IGW --> ALB[Application Load Balancer]

    %% Availability Zone A Structure
    subgraph AZA [Availability Zone: us-east-1a]
        direction TB
        subgraph PubSub1 [Public Subnet: 10.0.1.0/24]
            ALB_NodeA[ALB Node A]
        end
        subgraph PrivSub1 [Private Subnet: 10.0.11.0/24]
            EC2_1[Nginx EC2 Instance 1]
        end
        subgraph DBSub1 [Database Subnet]
            RDS_Primary[(MySQL RDS Primary)]
        end
    end

    %% Availability Zone B Structure
    subgraph AZB [Availability Zone: us-east-1b]
        direction TB
        subgraph PubSub2 [Public Subnet: 10.0.2.0/24]
            ALB_NodeB[ALB Node B]
        end
        subgraph PrivSub2 [Private Subnet: 10.0.12.0/24]
            EC2_2[Nginx EC2 Instance 2]
        end
        subgraph DBSub2 [Database Subnet]
            RDS_Replica[(MySQL RDS Replica)]
        end
    end

    %% Infrastructure Routing Paths
    ALB --> ALB_NodeA
    ALB --> ALB_NodeB
    ALB_NodeA --> EC2_1
    ALB_NodeB --> EC2_2
    EC2_1 --> RDS_Primary
    EC2_2 --> RDS_Replica

    %% Professional AWS Color Palette Styling
    style Internet fill:#fff,stroke:#333,stroke-width:1px
    style IGW fill:#fff,stroke:#333,stroke-width:1px
    style ALB fill:#ff9900,stroke:#d68100,stroke-width:2px,color:#fff
    style ALB_NodeA fill:#f2b65e,stroke:#d68100,stroke-width:1px
    style ALB_NodeB fill:#f2b65e,stroke:#d68100,stroke-width:1px
    style EC2_1 fill:#ff9900,stroke:#d68100,stroke-width:1px,color:#fff
    style EC2_2 fill:#ff9900,stroke:#d68100,stroke-width:1px,color:#fff
    style RDS_Primary fill:#3b7fbc,stroke:#2a5a84,stroke-width:2px,color:#fff
    style RDS_Replica fill:#3b7fbc,stroke:#2a5a84,stroke-width:2px,color:#fff
```
