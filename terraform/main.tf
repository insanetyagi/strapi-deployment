provider "aws" {
  region = var.aws_region

}

resource "aws_instance" "strapi_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.instance_profile

  user_data = templatefile("${path.module}/user_data.sh", {
    image_tag = var.image_tag,
    ecr_url   = var.ecr_repository_url
  })

  tags = {
    Name = "strapi-instance"
  }
}
