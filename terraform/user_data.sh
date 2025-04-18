#!/bin/bash
exec > /var/log/user-data.log 2>&1

# Update packages and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io awscli

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Authenticate Docker with ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ecr_url%/*}

# Pull image from ECR with tag
docker pull ${ecr_url}:${image_tag}

# Run container
docker run -d -p 80:1337 ${ecr_url}:${image_tag}
