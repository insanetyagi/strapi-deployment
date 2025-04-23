# Task 6: CI/CD Pipeline for Strapi on AWS ECS Fargate

## Overview

This task involved setting up a complete CI/CD pipeline for a Strapi application deployed to AWS ECS Fargate using GitHub Actions and Terraform. The objective was to enable a fully automated, reliable deployment workflow with minimal manual intervention.

---

## Architecture

- **ECR**: Hosts the Docker image of the Strapi app.
- **ECS Fargate**: Runs the containerized application.
- **Application Load Balancer (ALB)**: Exposes the app publicly.
- **Terraform**: Manages infrastructure provisioning.
- **GitHub Actions**: Automates build and deployment process.

---

## CI/CD Workflow

### 🔧 Build & Push to ECR (`ci.yml`)
Triggered on changes to app source (`my-project/`) or Dockerfile.

Steps:
1. Checkout source code.
2. Configure AWS credentials via GitHub Secrets.
3. Authenticate to ECR.
4. Build Docker image and tag with `latest` + Git SHA.
5. Push image to Amazon ECR.

### 🚀 Deploy Infrastructure (`action.yml`)
Triggered on changes to `terraform2/` directory or manually.

Steps:
1. Checkout code.
2. Configure AWS credentials.
3. Initialize and apply Terraform config.
4. Deploy ECS Task using latest image from ECR.

---

## Environment Variables & Secrets

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: Stored securely in GitHub Secrets.
- ECR image URL managed via `variables.tf`.

---

## Outputs

- 🟢 On successful deployment, the application is accessible via the **public Load Balancer URL**.
- Infrastructure is completely reproducible and destroyable using:
  ```bash
  cd terraform2
  terraform destroy
