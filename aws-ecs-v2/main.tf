locals {
  prefix            = "mor"
  region            = "us-east-1"
  availability_zone = "us-east-1a"
}

provider "aws" {
  profile = "mfa"
  region  = local.region
}

data "aws_ecs_cluster" "dop-example" {
  cluster_name = "ecs-test"
}

resource "aws_cloudwatch_log_group" "rookout" {
  name_prefix = "rookout/"
}

resource "aws_iam_role_policy" "task_exec_role_policy" {
  name = "test_policy"
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
  name = "${local.prefix}-exec-role"

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
    aws_region    = local.region
    rookout_token = var.rookout_token
  })
}

resource "aws_ecs_service" "controller" {
  name            = "${local.prefix}-rookout-controller"
  cluster         = data.aws_ecs_cluster.dop-example.id
  task_definition = aws_ecs_task_definition.controller.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.allow_controller.id]
    subnets          = [data.aws_subnet.selected.id]
    assign_public_ip = true
  }
}

resource "aws_cloudwatch_log_stream" "controller_log_stream" {
  name           = "controller"
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
    name          = "rookout-datastore"
    cpu           = 256
    memory        = 512
    log_group     = aws_cloudwatch_log_group.rookout.name
    log_stream    = aws_cloudwatch_log_stream.datastore_log_stream.name
    aws_region    = local.region
    rookout_token = var.rookout_token
    datastore_server_mode = var.datastore_server_mode
  })
}
resource "aws_ecs_service" "datastore" {
  name            = "${local.prefix}-rookout-datastore"
  cluster         = data.aws_ecs_cluster.dop-example.id
  task_definition = aws_ecs_task_definition.datastore.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.allow_controller.id]
    subnets          = [data.aws_subnet.selected.id]
    assign_public_ip = true
  }
}
resource "aws_cloudwatch_log_stream" "datastore_log_stream" {
  name           = "datastore"
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

###### Network
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

resource "aws_security_group" "allow_controller" {
  name        = "${local.prefix}-sg-allow-rookout-controller"
  description = "Allow inbound/outbound traffic for Rookout controller"
  vpc_id      = data.aws_vpc.selected.id
  ingress {
    description = "Inbound from IGW to controller"
    from_port   = 7488
    to_port     = 7488
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Inbound from IGW to datastore"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
