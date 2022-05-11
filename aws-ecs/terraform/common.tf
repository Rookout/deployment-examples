provider "aws" {
  region = var.region
}

data "aws_ecs_cluster" "provided" {
  count        = local.create_cluster ? 0 : 1
  cluster_name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "rookout" {
  name_prefix = local.name_prefix
}

resource "aws_ecs_cluster" "rookout" {
  count        = local.create_cluster ? 1 : 0
  name         = local.cluster_name
}

resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = var.prviate_namespace_name
  description = "${local.name_prefix} Local cloud map namespaces for ECS cluster."
  vpc         = var.vpc_id
}

resource "aws_lb" "alb" {
  count = var.create_lb ? 1 : 0

  name               = local.deployment_id
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_alb[0].id]
  subnets            = var.public_subnets
  tags               = local.tags
}

resource "aws_security_group" "allow_alb" {
  count = var.create_lb ? 1 : 0

  name        = "alb-${local.deployment_id}"
  description = "Allow inbound/outbound traffic for Application Load Balancer"
  vpc_id      = var.vpc_id
  ingress {
    description = "Inbound from IGW to datastore"
    from_port   = local.datastore_lb_port
    to_port     = local.datastore_lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Inbound from IGW to controller"
    from_port   = local.controller_lb_port
    to_port     = local.controller_lb_port
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
  tags = local.tags
}