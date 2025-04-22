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
  default = "118273046134.dkr.ecr.us-east-1.amazonaws.com/vishal-strapi-app:c1e979169bd6348e9ba4339ccd287b2a002f8c84"
}
