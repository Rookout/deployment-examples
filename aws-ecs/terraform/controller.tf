resource "aws_ecs_task_definition" "controller" {
  count = local.controller_settings.deploy ? 1 : 0

  family                   = format("%s-%s", local.controller_settings.container_name, local.name_prefix)
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = local.controller_settings.task_cpu
  memory                   = local.controller_settings.task_memory
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  task_role_arn            = aws_iam_role.task_exec_role.arn
  container_definitions    = local.controller_definition
  
  dynamic "volume" {
    for_each = local.controller_volumes
    content {
      name = volume.value["name"]
    }
  }
  tags = local.tags
}

resource "aws_ecs_service" "controller" {
  count = local.controller_settings.deploy ? 1 : 0

  name            = local.controller_name
  cluster         = local.create_cluster ? aws_ecs_cluster.rookout[0].id : data.aws_ecs_cluster.provided[0].id
  task_definition = aws_ecs_task_definition.controller[0].arn
  desired_count   = 1
  launch_type     = var.launch_type
  dynamic "load_balancer" {
    for_each = local.load_balancer_controller
    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }
  service_registries {
    registry_arn = aws_service_discovery_service.controller[0].arn
  }
  network_configuration {
    security_groups  = [aws_security_group.allow_controller[0].id]
    subnets          = local.task_subnets
    assign_public_ip = var.default_vpc
  }
  tags = local.tags
}

resource "aws_cloudwatch_log_stream" "controller_log_stream" {
  count = local.controller_settings.deploy ? 1 : 0

  name           = local.controller_name
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

resource "aws_service_discovery_service" "controller" {
  count = local.datastore_settings.deploy ? 1 : 0

  name = "${local.name_prefix}-controller"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.main.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold = 1
  }
}

# Network

resource "aws_lb_target_group" "controller" {
  count = local.controller_publish_lb ? 1 : 0

  name        = local.controller_name
  port        = local.controller_port
  protocol    = local.controller_tg_protocol
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    protocol = local.controller_tg_protocol
  }
}

resource "aws_lb_listener" "controller" {
  count = local.controller_publish_lb ? 1 : 0

  load_balancer_arn = local.load_balancer_arn
  port              = local.controller_lb_port
  protocol          = local.controller_lb_protocol
  certificate_arn   = local.controller_settings.certificate_arn != null ? local.controller_settings.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.controller[0].arn
  }
}

resource "aws_security_group" "allow_controller" {
  count = local.datastore_settings.deploy ? 1 : 0

  name        = local.controller_name
  description = "Allow inbound/outbound traffic for Rookout controller"
  vpc_id      = var.vpc_id
  ingress {
    description = "Inbound from IGW to controller"
    from_port   = local.controller_port
    to_port     = local.controller_port
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
