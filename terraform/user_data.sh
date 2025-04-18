#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y docker.io awscli
sudo systemctl start docker
sudo systemctl enable docker

# Login to ECR
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin ${ecr_url%%/*}

# Pull and run the Docker image from ECR
sudo docker pull ${ecr_url}:${image_tag}
sudo docker run -d -p 80:1337 ${ecr_url}:${image_tag}
