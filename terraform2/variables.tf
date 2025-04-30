variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecr_image_url" {
  description = "ECR image URI with commit SHA tag"
  type        = string
  default     = "471112855731.dkr.ecr.us-east-1.amazonaws.com/vishal-strapi-fargate:latest"
}

variable "codedeploy_role_arn" {
  description = "ARN of the existing IAM role for CodeDeploy"
  type        = string
  default     = "arn:aws:iam::471112855731:role/CodeDeployECSServiceRole"
}

variable "container_name" {
  description = "Name of the container in ECS"
  type        = string
  default     = "strapi"
}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number
  default     = 80
}
variable "is_green_deployment" {
  description = "Whether the green deployment target group is used"
  type        = bool
  default     = false  # Set default to false if you don't want green deployments by default
}
