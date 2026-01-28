# Automated Container Deployment: AWS ECS Fargate & Terraform

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-purple) ![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange) ![Docker](https://img.shields.io/badge/Docker-Container-blue)

## 📖 Overview
This project automates the deployment of a containerized Node.js application to **AWS ECS (Fargate)** using a fully managed **Infrastructure as Code (IaC)** pipeline.

It replaces manual console provisioning with a reproducible Terraform workflow, handling VPC networking, ECR image management, and ECS Service auto-scaling.

## 🏗️ Architecture
* **Compute:** AWS ECS Fargate (Serverless Container Orchestration)
* **Registry:** Amazon ECR (Elastic Container Registry)
* **Networking:** Custom VPC with `awsvpc` network mode for task-level security.
* **Infrastructure:** Defined entirely in Terraform (HCL).

## 🚀 Deployment Guide

### 1. Build & Push Image
Authenticate with AWS ECR and push the Docker image:
```bash
# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.us-east-1.amazonaws.com

# Build & Push
docker build -t my-node-app ./app
docker tag my-node-app:latest <your-repo-url>:latest
docker push <your-repo-url>:latest
```

### 2. Provision Infrastructure
Deploy the cloud resources using Terraform:
```bash
cd terraform/
terraform init
terraform plan
terraform apply --auto-approve
```

## 🔧 Technical Challenges & Solutions
### Issue: `awsvpc` Network Mode Connectivity
**Problem:** The ECS Tasks failed to start with a `Network Configuration must be provided` error.
**Solution:** I configured the `aws_ecs_service` resource to explicitly reference the custom VPC Subnets and Security Groups, ensuring the Fargate tasks had valid ENIs (Elastic Network Interfaces) to communicate with the internet.

## 🧹 Cleanup
To destroy all resources and prevent AWS charges:
```bash
terraform destroy
```
