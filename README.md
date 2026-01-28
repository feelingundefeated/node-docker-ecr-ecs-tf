# ☁️ Automated Container Deployment: AWS ECS Fargate & Terraform

A production-ready DevOps pipeline that containerizes a Node.js application and deploys it to **AWS ECS (Fargate)** using a fully managed **Infrastructure as Code (IaC)** workflow.

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-purple?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-ECS_Fargate-FF9900?style=for-the-badge&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Container-blue?style=for-the-badge&logo=docker)

## 📖 Overview

This project replaces manual console provisioning with a reproducible Terraform pipeline. It handles:
* **VPC Networking:** Secure task isolation using `awsvpc` network mode.
* **ECR Management:** Automated Docker image registry for artifact versioning.
* **ECS Auto-Scaling:** Serverless Fargate tasks that scale based on demand.

## 🏗️ Architecture

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Compute** | AWS ECS Fargate | Serverless container orchestration. |
| **Registry** | Amazon ECR | Secure storage for Docker images. |
| **Networking** | VPC / Security Groups | Strict ingress rules allowing traffic only on port 3000. |
| **IaC** | Terraform (HCL) | Fully automated infrastructure provisioning. |

## 🚀 Deployment Guide

### Prerequisites
* AWS CLI configured (`us-west-2` region).
* Terraform installed.
* Docker Desktop running.

### 1. Build & Push Image
Authenticate with AWS ECR and push the Docker image to the `us-west-2` region.

```bash
# 1. Login to ECR
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <YOUR_AWS_ACCOUNT_ID>.dkr.ecr.us-west-2.amazonaws.com

# 2. Build the Image
docker build -t my-first-ecr-repo ./app

# 3. Tag & Push
docker tag my-first-ecr-repo:latest <YOUR_AWS_ACCOUNT_ID>[.dkr.ecr.us-west-2.amazonaws.com/my-first-ecr-repo:latest](https://.dkr.ecr.us-west-2.amazonaws.com/my-first-ecr-repo:latest)
docker push <YOUR_AWS_ACCOUNT_ID>[.dkr.ecr.us-west-2.amazonaws.com/my-first-ecr-repo:latest](https://.dkr.ecr.us-west-2.amazonaws.com/my-first-ecr-repo:latest)

2. Provision Infrastructure
Deploy the cloud resources using Terraform:
cd terraform/
terraform init
terraform plan
terraform apply --auto-approve

🔧 Technical Challenges & Solutions
Issue: awsvpc Network Mode Connectivity
Problem: The ECS Tasks initially failed to start with a Network Configuration must be provided error.

Solution: I configured the aws_ecs_service resource to explicitly reference the VPC Subnets and Security Groups. This ensures Fargate tasks receive valid ENIs (Elastic Network Interfaces) to communicate with the internet and pull images from ECR.

🧹 Cleanup
To destroy all resources and prevent AWS charges:
terraform destroy --auto-approve
