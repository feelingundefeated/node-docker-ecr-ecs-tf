# Automated Container Deployment: AWS ECS Fargate & Terraform

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-purple) ![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange) ![Docker](https://img.shields.io/badge/Docker-Container-blue)

## 📖 Overview
This project automates the deployment of a containerized Node.js application to **AWS ECS (Fargate)** using a fully managed **Infrastructure as Code (IaC)** pipeline.

## 🚀 Deployment Guide
1. **Build & Push:** Authenticate with ECR and push the Docker image.
2. **Provision:** Run `terraform apply` to deploy the infrastructure.

## 🔧 Technical Challenges
**Issue:** `awsvpc` Network Mode Connectivity.
**Solution:** Explicitly configured Security Groups to allow traffic on port 3000.
