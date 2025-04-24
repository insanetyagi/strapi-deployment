Task 7: Monitoring & Alerting for Strapi on AWS ECS Fargate
Overview
This task focused on implementing CloudWatch monitoring and alerting for a Strapi application deployed on AWS ECS Fargate. The goal was to ensure the application is continuously observable and any performance issues trigger real-time alarms.

Monitoring Setup
CloudWatch Logs: Integrated with ECS to stream container logs in real-time.

CloudWatch Alarms: Configured for CPU and Memory utilization.

CloudWatch Dashboard: Visual representation of app performance metrics.

Resources Involved
✅ Log Group
/ecs/strapi: Receives container logs via awslogs driver from ECS Task Definition.

✅ Alarms
High CPU Utilization Alarm
Triggers if average CPU > 80% for 2 minutes.

High Memory Utilization Alarm
Triggers if average Memory > 80% for 2 minutes.

✅ Dashboard
StrapiMonitoringDashboard
Displays ECS service metrics like CPU and Memory usage in a clean time-series layout.

How It Works
ECS task definition includes a logConfiguration block for AWS Logs.

Task logs are streamed into CloudWatch log group /ecs/strapi.

Metric alarms continuously evaluate usage.

Dashboard updates in real-time based on ECS metrics and task activity.

Verification Steps
Log Streams:

Navigate to CloudWatch → Log groups → /ecs/strapi

Confirm logs are streaming from latest ECS tasks.

Alarms:

Go to CloudWatch → Alarms → Check HighCPUUtilization and HighMemoryUtilization status.

Dashboard:

View metrics on StrapiMonitoringDashboard for live ECS resource tracking.

ECS Health:

ECS Console → Cluster → Services → Check service is RUNNING and stable.

Notes
Alerts can be extended to SNS or email notifications in future.

Log retention is set to 7 days (configurable in cloudwatch.tf).