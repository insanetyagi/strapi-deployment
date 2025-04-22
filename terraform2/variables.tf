variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecr_image_url" {
  description = "ECR image URI with commit SHA tag - auto-injected by GitHub Actions"
  type        = string
  default     = "118273046134.dkr.ecr.us-east-1.amazonaws.com/vishal-strapi-fargate:latest"
}