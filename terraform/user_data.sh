#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y docker.io awscli

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Set AWS credentials passed via environment variables (if needed for EC2 without IAM role)
echo "export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" | sudo tee -a /etc/profile
echo "export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" | sudo tee -a /etc/profile
echo "export AWS_DEFAULT_REGION=us-east-1" | sudo tee -a /etc/profile
source /etc/profile

# Login to Amazon ECR
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin ${ecr_registry}

# Pull and run the Docker image
sudo docker pull ${ecr_url}:${image_tag}
sudo docker run -d -p 80:1337 ${ecr_url}:${image_tag}
