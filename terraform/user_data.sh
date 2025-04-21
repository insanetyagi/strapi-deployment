#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y docker.io awscli

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Export AWS credentials (for ECR login only)
export AWS_ACCESS_KEY_ID="${aws_access_key_id}"
export AWS_SECRET_ACCESS_KEY="${aws_secret_access_key}"
export AWS_DEFAULT_REGION="us-east-1"

# Log in to Amazon ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ecr_registry}

# Pull the Docker image
docker pull ${ecr_url}:${image_tag}

# Run the container in detached mode on port 80
docker run -d \
  -e HOST=0.0.0.0 \
  -e PORT=80 \
  -e NODE_ENV=production \
  -e APP_KEYS=mySuperSecretKey1,mySuperSecretKey2 \
  -p 80:80 \
  ${ecr_url}:${image_tag} > /home/ubuntu/docker-run.log 2>&1
