#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${ecr_url%%/*}
docker pull ${ecr_url}:${image_tag}
docker run -d -p 80:80 ${ecr_url}:${image_tag}
