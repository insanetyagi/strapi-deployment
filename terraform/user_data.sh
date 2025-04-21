#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y docker.io awscli

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Export AWS credentials
export AWS_ACCESS_KEY_ID="${aws_access_key_id}"
export AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"
export AWS_DEFAULT_REGION="us-east-1"

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ecr_registry}

# Pull and run the Docker image
docker pull ${ecr_url}:${image_tag}
docker run -d -p 80:1337 ${ecr_url}:${image_tag}
