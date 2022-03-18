provider "aws" {
  region = var.region
}

data "aws_secretsmanager_secret" "rookout_token" {
  arn = var.rookout_token_arn
}

data "aws_ecs_cluster" "provided" {
  count        = local.create_cluster ? 0 : 1
  cluster_name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "rookout" {
  name_prefix = "${var.service}/"
}

resource "aws_ecs_cluster" "rookout" {
  count = local.create_cluster ? 1 : 0
  name  = local.cluster_name
}

### Controller
resource "aws_ecs_task_definition" "controller" {
  family                   = "rookout_controller"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile("${path.module}/templates/controller_task_def.tpl", {
    name              = "rookout-controller"
    cpu               = 256
    memory            = 512
    log_group         = aws_cloudwatch_log_group.rookout.name
    log_stream        = aws_cloudwatch_log_stream.controller_log_stream.name
    aws_region        = var.region
    rookout_token_arn = var.rookout_token_arn
  })
}

resource "aws_ecs_service" "controller" {
  name            = "${local.name_prefix}-controller"
  cluster         = local.create_cluster ? aws_ecs_cluster.rookout[0].id : data.aws_ecs_cluster.provided[0].id
  task_definition = aws_ecs_task_definition.controller.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  dynamic "load_balancer" {
    for_each = local.load_balancer_controller
    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }
  service_registries {
    registry_arn = aws_service_discovery_service.datastore.arn
  }
  network_configuration {
    security_groups  = [aws_security_group.allow_controller.id]
    subnets          = local.task_subnets
    assign_public_ip = var.default_vpc
  }
}

resource "aws_cloudwatch_log_stream" "controller_log_stream" {
  name           = "${local.name_prefix}-controller"
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

### Datastore
resource "aws_ecs_task_definition" "datastore" {
  family                   = "rookout_datastore"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile(local.datastore_server_mode == "TLS" ? "${path.module}/templates/datastore_tls_task_def.tpl" : "${path.module}/templates/datastore_task_def.tpl", {
    name                      = "rookout-datastore"
    cpu                       = 256
    memory                    = 512
    log_group                 = aws_cloudwatch_log_group.rookout.name
    log_stream                = aws_cloudwatch_log_stream.datastore_log_stream.name
    aws_region                = var.region
    rookout_token_arn         = var.rookout_token_arn
    datastore_server_mode     = local.datastore_server_mode
    certificate_bucket_name   = var.certificate_bucket_name == null ? "dummy" : var.certificate_bucket_name
    certificate_bucket_prefix = var.certificate_bucket_prefix == null ? "dummy" : var.certificate_bucket_prefix
  })
  dynamic "volume" {
    for_each = local.datastore_volumes
    content {
      name = volume.value
    }
  }
}
resource "aws_ecs_service" "datastore" {
  name            = "${local.name_prefix}-datastore"
  cluster         = local.create_cluster ? aws_ecs_cluster.rookout[0].id : data.aws_ecs_cluster.provided[0].id
  task_definition = aws_ecs_task_definition.datastore.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  dynamic "load_balancer" {
    for_each = local.load_balancer_datastore
    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }
  service_registries {
    registry_arn = aws_service_discovery_service.datastore.arn
  }
  network_configuration {
    security_groups  = [aws_security_group.allow_datastore.id]
    subnets          = local.task_subnets
    assign_public_ip = var.default_vpc
  }
}
resource "aws_cloudwatch_log_stream" "datastore_log_stream" {
  name           = "${local.name_prefix}-datastore"
  log_group_name = aws_cloudwatch_log_group.rookout.name
}

###### Service Discovery

resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = var.prviate_namespace_name
  description = "${local.name_prefix} Local cloud map namespaces for ECS cluster."
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "controller" {
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

resource "aws_service_discovery_service" "datastore" {
  name = "${local.name_prefix}-datastore"

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

###### Network

resource "aws_lb" "alb" {
  count = var.create_lb ? 1 : 0

  name               = "${local.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_alb[0].id]
  subnets            = var.public_subnets
  tags               = local.tags
}

resource "aws_lb_target_group" "controller" {
  count = var.create_lb && var.publish_controller_lb ? 1 : 0

  name        = "${local.name_prefix}-datastore"
  port        = 7488
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "controller" {
  count = var.create_lb && var.publish_controller_lb ? 1 : 0

  load_balancer_arn = aws_lb.alb[0].arn
  port              = 7488
  protocol          = local.datastore_lb_protocol
  certificate_arn   = var.certificate_arn != null ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.datastore[0].arn
  }
}

resource "aws_lb_target_group" "datastore" {
  count = var.create_lb ? 1 : 0

  name        = "${local.name_prefix}-datastore"
  vpc_id      = var.vpc_id
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  health_check {
    path = "/healthz"
  }
}

resource "aws_lb_listener" "datastore" {
  count = var.create_lb ? 1 : 0

  load_balancer_arn = aws_lb.alb[0].arn
  port              = 8080
  protocol          = local.datastore_lb_protocol
  certificate_arn   = var.certificate_arn != null ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.datastore[0].arn
  }
}

resource "aws_security_group" "allow_controller" {
  name        = "${local.name_prefix}-controller"
  description = "Allow inbound/outbound traffic for Rookout controller"
  vpc_id      = var.vpc_id
  ingress {
    description = "Inbound from IGW to controller"
    from_port   = 7488
    to_port     = 7488
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

resource "aws_security_group" "allow_datastore" {
  name        = "${local.name_prefix}-datastore"
  description = "Allow inbound/outbound traffic for Rookout datastore"
  vpc_id      = var.vpc_id
  ingress {
    description = "Inbound from IGW to datastore"
    from_port   = local.datastore_port
    to_port     = local.datastore_port
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

resource "aws_security_group" "allow_alb" {
  count = var.create_lb ? 1 : 0

  name        = "${local.name_prefix}-alb"
  description = "Allow inbound/outbound traffic for Application Load Balancer"
  vpc_id      = var.vpc_id
  ingress {
    description = "Inbound from IGW to datastore"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Inbound from IGW to controller"
    from_port   = 7488
    to_port     = 7488
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