provider "aws" {
  version = "~> 2"
  region = local.region
}

# Just Supporting Infrastructures

data "aws_availability_zones" "available" {}

locals {
  prefix = "easy-fargate-alb"

  vpc_cidr       = "10.0.0.0/16"
  discovered_azs = data.aws_availability_zones.available.names
  vpc_azs        = length(var.availability_zones) == 0 ? local.discovered_azs : var.availability_zones
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.18.0"

  name = "${local.prefix}-vpc"
  cidr = local.vpc_cidr
  azs  = local.vpc_azs

  public_subnets = [for i in range(length(local.vpc_azs)) : cidrsubnet(local.vpc_cidr, 8, i)]

  enable_nat_gateway               = false
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  enable_ipv6                                   = var.enable_ipv6
  assign_ipv6_address_on_creation               = var.enable_ipv6
  public_subnet_assign_ipv6_address_on_creation = var.enable_ipv6
  public_subnet_ipv6_prefixes                   = range(length(local.vpc_azs))
}

module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.2.0"

  name   = "${local.prefix}-alb-sg"
  vpc_id = module.vpc.vpc_id

  # Ingress for HTTP
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  ingress_rules            = ["all-tcp"]

  # Allow all egress
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]
}

module "task_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.2.0"

  name   = "${local.prefix}-task-sg"
  vpc_id = module.vpc.vpc_id


  # Ingress from ALB only
  number_of_computed_ingress_with_source_security_group_id = 1
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.alb_security_group.this_security_group_id
    }
  ]

  # Allow all egress
  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]
  egress_rules            = ["all-all"]
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "example" {
  key_algorithm   = "${tls_private_key.example.algorithm}"
  private_key_pem = "${tls_private_key.example.private_key_pem}"

  # Certificate expires after 12 hours.
  validity_period_hours = 12

  # Generate a new certificate if Terraform is run within three
  # hours of the certificate's expiration time.
  early_renewal_hours = 3

  # Reasonable set of uses for a server SSL certificate.
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = [module.alb.this_lb_dns_name]

  subject {
    common_name  = "easy-fargate-alb-alb-872028889.us-east-1.elb.amazonaws.com"
    organization = "ACME Examples, Inc"
  }
}

# For example, this can be used to populate an AWS IAM server certificate.
resource "aws_iam_server_certificate" "example" {
  name             = "example_self_signed_cert"
  certificate_body = "${tls_self_signed_cert.example.cert_pem}"
  private_key      = "${tls_private_key.example.private_key_pem}"
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name               = "${local.prefix}-alb"
  load_balancer_type = "application"
  security_groups    = [module.alb_security_group.this_security_group_id]
  subnets            = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id

  ip_address_type = var.enable_ipv6 ? "dualstack" : "ipv4"

  listener_ssl_policy_default = "ELBSecurityPolicy-2016-08"
  http_tcp_listeners = [
    {
      target_group_index = 0
      port               = 7488
      protocol           = "HTTP"
    },
  ]

  https_listeners = [
    {
      target_group_index = 1
      port                 = 8080
      certificate_arn      = aws_iam_server_certificate.example.arn
    }
  ]

  target_groups = [
    {
      name             = "${local.prefix}-app"
      backend_protocol = "HTTP"
      backend_port     = 7488
      target_type      = "ip"
    },
    {
      name             = "${local.prefix}-app2"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "ip"
      health_check = {
        path: "/healthz",
        port: 8080
      }
    },
  ]
}

# This module usage starts here
module "ecs_cluster" {
  source = "../../.."

  name = "${local.prefix}-cluster"
}

module "controller_service" {
  source = "../../../modules/simple/fargate"

  name                         = "${local.prefix}-controller-service"
  cluster                      = module.ecs_cluster.name
  cpu                          = 256
  memory                       = 512
  desired_count                = 1
  ignore_desired_count_changes = false

  security_groups  = [module.task_security_group.this_security_group_id]
  vpc_subnets      = module.vpc.public_subnets
  assign_public_ip = true

  # Workaround when destroy fails
  target_group_arn = length(module.alb.target_group_arns) == 0 ? "" : module.alb.target_group_arns[0]
  # container_name must be the same with the name defined in container_definitions!
  container_name = "${local.prefix}-cont-controller"
  container_port = 7488
  iam_task_role = aws_iam_role.task_exec_role.arn
  iam_daemon_role = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile("./controller_task_def.tpl", {
    name   = "${local.prefix}-cont-controller"
    cpu    = 256
    memory = 512
    log_group = aws_cloudwatch_log_group.rookout_logs.name
    log_stream = aws_cloudwatch_log_stream.controller_log_stream.name
    aws_region = local.region
  })
}

module "dop_service" {
  source = "../../../modules/simple/fargate"

  name                         = "${local.prefix}-dop-service"
  cluster                      = module.ecs_cluster.name
  cpu                          = 256
  memory                       = 512
  desired_count                = 1
  ignore_desired_count_changes = false

  security_groups  = [module.task_security_group.this_security_group_id]
  vpc_subnets      = module.vpc.public_subnets
  assign_public_ip = true

  # Workaround when destroy fails
  target_group_arn = length(module.alb.target_group_arns) == 0 ? "" : module.alb.target_group_arns[1]
  # container_name must be the same with the name defined in container_definitions!
  container_name = "${local.prefix}-cont-dop"
  container_port = 8080
  iam_task_role = aws_iam_role.task_exec_role.arn
  iam_daemon_role = aws_iam_role.task_exec_role.arn
  container_definitions = templatefile("./dop_task_def.tpl", {
    name   = "${local.prefix}-cont-dop"
    cpu    = 256
    memory = 512
    log_group = aws_cloudwatch_log_group.rookout_logs.name
    log_stream = aws_cloudwatch_log_stream.dop_log_stream.name
    aws_region = local.region
  })
}

resource "aws_cloudwatch_log_group" "rookout_logs" {
  name = "rookout-logs"
}

resource "aws_cloudwatch_log_stream" "controller_log_stream" {
  name           = "controller"
  log_group_name = aws_cloudwatch_log_group.rookout_logs.name
}

resource "aws_cloudwatch_log_stream" "dop_log_stream" {
  name           = "dop"
  log_group_name = aws_cloudwatch_log_group.rookout_logs.name
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
  name = "test_role"

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