variable "azs" {
  description = "List of availability zones to use."
  type = list(string)
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}

variable "public_cidrs" {
  description = "List of public subnets cidrs to create"
  type        = list(string)
}

variable "private_cidrs" {
  description = "List of private subnets cidrs to create"
  type        = list(string)
}

variable "create_lb" {
  description = "Set to true if you want to publish services publicly via Application Load Balancer"
  type        = bool
  default     = false
}

variable "publish_controller_lb" {
  description = "Set true if you want to publish controller trough LoadBalancer. create_lb parameter should be set to true."
  type   = bool
  default = false
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