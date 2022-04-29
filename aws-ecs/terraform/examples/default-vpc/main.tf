provider "aws" {
  region = var.region
}

locals {
  tags = {
    Terraform   = "true"
    Environment = var.environment
    Service     = "rookout"
  }
}

module "rookout" {
  source = "../../"

  vpc_id                 = var.vpc_id
  public_subnets         = var.public_subnets
  default_vpc            = var.default_vpc
  region                 = var.region
  rookout_token_arn      = var.rookout_token_arn
  environment            = var.environment
  prviate_namespace_name = var.prviate_namespace_name
  controller_settings    = var.controller_settings
  datastore_settings     = var.datastore_settings
  cluster_name           = var.cluster_name

  tags = local.tags
}

output "rookout" {
  value = module.rookout
}