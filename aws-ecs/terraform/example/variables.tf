variable "azs" {
  description = "List of availability zones to use."
  type = list(string)
}

variable "vpc_cidr" {
  description = "VPC ID"
  type        = string
}

variable "public_cidrs" {
  description = "Subnet ID"
  type        = list(string)
}

variable "private_cidrs" {
  description = "Subnet ID"
  type        = list(string)
}

variable "create_lb" {
  description = "Set to true if you want to publish services publically via Application Load Balancer"
  type        = bool
}

variable "publish_controller_lb" {
  type    = bool
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "rookout_token_arn" {
  description = "Token of your Rookout organization"
  type        = string
}

variable "environment" {
  description = "Environment name prefix to use in all created resources"
  type        = string
  
}

variable "certificate_arn" {
  description = "AWS ACM Certificate ARN to attach to load balancer"
  type        = string
}

variable "prviate_namespace_name" {
  type    = string
}