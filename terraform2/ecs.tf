# 1. ECS Cluster
resource "aws_ecs_cluster" "tyagi_cluster" {
  name = "tyagi-cluster"
}

# 2. ECS Task Definition 
resource "aws_ecs_task_definition" "tyagi_task" {
  family                   = "tyagi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::118273046134:role/ecsTaskExecutionRole1"

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = var.ecr_image_url
    essential = true

    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]

    environment = [
      { name = "HOST",                value = "0.0.0.0" },
      { name = "PORT",                value = "80" },
      { name = "NODE_ENV",            value = "production" },
      { name = "APP_KEYS",            value = "mySuperSecretKey1,mySuperSecretKey2" },
      { name = "JWT_SECRET",          value = "myVerySecretJWT" },
      { name = "API_TOKEN_SALT",      value = "myVerySecretSalt" },
      { name = "ADMIN_JWT_SECRET",    value = "myVeryAdminJWTSecret" },
      { name = "TRANSFER_TOKEN_SALT", value = "myTransferSalt" },
      { name = "FLAG_NPS",            value = "true" },
      { name = "FLAG_PROMOTE_EE",     value = "true" }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/tyagi"
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs/tyagi"
      }
    }
  }])
}

# 3. ECS Service
resource "aws_ecs_service" "tyagi_service" {
  name            = "tyagi-service"
  cluster         = aws_ecs_cluster.tyagi_cluster.id
  task_definition = aws_ecs_task_definition.tyagi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.tyagi_subnet[*].id
    security_groups = [aws_security_group.tyagi_ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tyagi_tg.arn
    container_name   = "strapi"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.tyagi_listener]
}
