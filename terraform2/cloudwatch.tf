# Log Group for ECS
resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/tyagi"
  retention_in_days = 7
}

# CPU Alarm
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU exceeds 80%"
  dimensions = {
    ClusterName = aws_ecs_cluster.tyagi_cluster.name
    ServiceName = aws_ecs_service.tyagi_service.name
  }
}

# Memory Alarm
resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "HighMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when memory exceeds 80%"
  dimensions = {
    ClusterName = aws_ecs_cluster.tyagi_cluster.name
    ServiceName = aws_ecs_service.tyagi_service.name
  }
}

# Dashboard (optional but helpful)
resource "aws_cloudwatch_dashboard" "strapi_dashboard" {
  dashboard_name = "StrapiMonitoringDashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.tyagi_cluster.name, "ServiceName", aws_ecs_service.tyagi_service.name ],
            [ ".", "MemoryUtilization", ".", ".", ".", "." ]
          ],
          view     = "timeSeries",
          stacked  = false,
          region   = var.aws_region,
          title    = "CPU & Memory Utilization"
        }
      }
    ]
  })
}
