output "instance_id" {
  value = aws_instance.strapi.id
}

output "public_ip" {
  value = aws_instance.strapi.public_ip
}

output "availability_zone" {
  value = aws_instance.strapi.availability_zone
}
