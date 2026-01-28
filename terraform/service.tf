# 1. Create a Security Group to allow port 3000
resource "aws_security_group" "service_sg" {
  name        = "ecs-service-sg"
  description = "Allow inbound traffic to ECS"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Update the Service to use it
resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_first_task.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  network_configuration {
    subnets          = [aws_default_subnet.default_subnet_a.id, aws_default_subnet.default_subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.service_sg.id] # This was missing!
  }
}