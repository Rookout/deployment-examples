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
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "rookout_token_arn" {
  description = "Secret's ARN for AWS Secrets Manager secret with rookout token."
  type        = string
}

variable "cluster_name" {
  description = "Set true if you want to use previously deployed cluster, if not set module will create new AWS ECS cluster as part of deployment."
  type        = string
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
