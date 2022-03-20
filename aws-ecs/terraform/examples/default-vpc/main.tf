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

module "rookout" {
  source = "../"

  vpc_id                    = var.vpc_id
  public_subnets            = var.public_subnets
  private_subnets           = var.private_subnets
  region                    = var.region
  rookout_token_arn         = var.rookout_token_arn
  environment               = var.environment
  certificate_bucket_name   = var.certificate_bucket_name
  certificate_bucket_prefix = var.certificate_bucket_prefix
  prviate_namespace_name    = var.prviate_namespace_name

  tags = local.tags
}