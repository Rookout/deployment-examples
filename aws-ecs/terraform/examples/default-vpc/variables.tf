variable "vpc_id" {
  description = "VPC ID for deployment"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for deployment"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnets for deployment"
  type        = list(string)
  default     = []
}

variable "default_vpc" {
  description = "Set true if you want to use default VPC or VPC without private networks."
  type        = bool
}

variable "region" {
  description = "AWS Region"
}

variable "rookout_token_arn" {
  description = "Secret's ARN for AWS Secrets Manager secret with rookout token."
}

variable "create_lb" {
  description = "Set to true if you want to publish services publicly via Application Load Balancer"
  type        = bool
}

variable "environment" {
  description = "Environment name prefix to use in all created resources"
  type        = string
}

variable "prviate_namespace_name" {
  description = "Name for AWS CloudMap namespace used for service discovery"
  type        = string
}

variable "controller_settings" {
  type = map(string)
}

variable "datastore_settings" {
  type = map(string)
}
