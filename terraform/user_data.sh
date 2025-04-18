#!/bin/bash
exec > /var/log/user-data.log 2>&1

# Install Docker & AWS CLI
apt-get update -y
apt-get install -y docker.io awscli

# Start Docker
systemctl start docker
systemctl enable docker

# Authenticate Docker with ECR
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ecr_url%/*}

# Pull image
docker pull ${ecr_url}:${image_tag}

# Run container
docker run -d -p 80:1337 ${ecr_url}:${image_tag}
