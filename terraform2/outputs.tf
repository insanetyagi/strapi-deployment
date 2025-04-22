output "alb_url" {
  description = "Public URL to access Strapi"
  value       = aws_lb.tyagi_alb.dns_name
}
