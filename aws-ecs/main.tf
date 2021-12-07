provider "aws" {
  profile = "mfa"
  region  = var.region
}

data "aws_ecs_cluster" "dop-example" {
  cluster_name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "rookout" {
  name_prefix = "rookout/"
}

resource "aws_iam_role_policy" "task_exec_role_policy" {
  name = "${var.name_prefix}-rookout_role_policy"
  role = aws_iam_role.task_exec_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "task_exec_role" {
  name = "${var.name_prefix}-exec-role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

### Controller
resource "aws_ecs_task_definition" "controller" {
  family                   = "rookout_controller"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile("./controller_task_def.tpl", {
    name          = "rookout-controller"
    cpu           = 256
    memory        = 512
    log_group     = aws_cloudwatch_log_group.rookout.name
    log_stream    = aws_cloudwatch_log_stream.controller_log_stream.name
    aws_region    = var.region
    rookout_token = var.rookout_token
  })
}

resource "aws_ecs_service" "controller" {
  name            = "${var.name_prefix}-rookout-controller"
  cluster         = data.aws_ecs_cluster.dop-example.id
  task_definition = aws_ecs_task_definition.controller.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.controller.id]
    subnets          = data.aws_subnets.selected.ids
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.controller.arn
    container_name   = "rookout-controller"
    container_port   = 7488
  }
}

resource "aws_cloudwatch_log_stream" "controller_log_stream" {
  name           = "${var.name_prefix}-controller"
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

### Datastore
resource "aws_ecs_task_definition" "datastore" {
  family                   = "rookout_datastore"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile("./datastore_task_def.tpl", {
    name                  = "rookout-datastore"
    cpu                   = 256
    memory                = 512
    log_group             = aws_cloudwatch_log_group.rookout.name
    log_stream            = aws_cloudwatch_log_stream.datastore_log_stream.name
    aws_region            = var.region
    rookout_token         = var.rookout_token
    datastore_server_mode = var.datastore_server_mode
  })
}
resource "aws_ecs_service" "datastore" {
  name            = "${var.name_prefix}-rookout-datastore"
  cluster         = data.aws_ecs_cluster.dop-example.id
  task_definition = aws_ecs_task_definition.datastore.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.datastore.id]
    subnets          = data.aws_subnets.selected.ids
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.datastore.arn
    container_name   = "rookout-datastore"
    container_port   = 8080
  }
}
resource "aws_cloudwatch_log_stream" "datastore_log_stream" {
  name           = "${var.name_prefix}-datastore"
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

###### Network
data "aws_vpc" "selected" {
  id = var.vpc_id
}
data "aws_subnets" "selected" {
  filter {
    name   = "availability-zone"
    values = var.availability_zones_names
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
resource "aws_security_group" "controller" {
  name   = "${var.name_prefix}-rookout-controller-sg"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    description     = "Inbound from ALB"
    from_port       = 7488
    to_port         = 7488
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    description      = "Outbound all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "datastore" {
  name   = "${var.name_prefix}-rookout-datastore-sg"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    description     = "Inbound from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    description      = "Outbound all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "main" {
  name               = "${var.name_prefix}-rookout-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.selected.ids

  enable_deletion_protection = false
}

resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-rookout-alb-sg"
  description = "TBD"
  vpc_id      = data.aws_vpc.selected.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb_target_group" "controller" {
  name        = "${var.name_prefix}-rookout-controller-alb-tg"
  port        = 7488
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_target_group" "datastore" {
  name        = "${var.name_prefix}-rookout-datastore-alb-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/healthz"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Use /datastore for Datastore or /controller for Controller"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "controller" {
  listener_arn = aws_alb_listener.http.arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.controller.arn
  }
  condition {
    path_pattern {
      values = ["/controller/*"]
    }
  }
}

resource "aws_lb_listener_rule" "datastore" {
  listener_arn = aws_alb_listener.http.arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.datastore.arn
  }
  condition {
    path_pattern {
      values = ["/datastore/*"]
    }
  }
}

