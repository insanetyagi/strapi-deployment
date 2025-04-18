variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the instance"
  type        = string
}

variable "instance_profile" {
  description = "IAM instance profile name for SSM access"
  type        = string
}

variable "image_tag" {
  description = "Tag of the Docker image to deploy"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URI (e.g. <account>.dkr.ecr.us-east-1.amazonaws.com/vishal-strapi-app)"
  type        = string
}