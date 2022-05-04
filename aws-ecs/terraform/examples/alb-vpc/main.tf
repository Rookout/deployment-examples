provider "aws" {
  region = var.region
}

locals {
  tags = {
    Terraform   = true
    Environment = var.environment
    Service     = "rookout"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment}-rookout-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_cidrs
  public_subnets  = var.public_cidrs

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

module "rookout" {
  source = "git::https://github.com/gchuev-opsfleet/deployment-examples.git//aws-ecs/terraform/?ref=OP-3-create-ecs-deployment-method-datastore-controller"

  vpc_id                 = module.vpc.vpc_id
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  create_lb              = var.create_lb
  region                 = var.region
  rookout_token_arn      = var.rookout_token_arn
  environment            = var.environment
  prviate_namespace_name = var.prviate_namespace_name
  controller_settings    = var.controller_settings
  datastore_settings     = var.datastore_settings
  existing_lb_arn        = var.existing_lb_arn

  tags = local.tags
}

output "rookout" {
  value = module.rookout
}