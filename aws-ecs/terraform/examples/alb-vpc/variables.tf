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
  default     = null
}

variable "environment" {
  description = "Environment name prefix to use in all created resources"
  type        = string
  default     = "dev"
}

variable "prviate_namespace_name" {
  description = "Name for AWS CloudMap namespace used for service discovery"
  type        = string
  default     = "cluster.local"
}

variable "controller_settings" {
  type = map(string)
  default = {
    enabled                   = true
    service_name              = "rookout-controller"
    server_mode               = "PLAIN"
    dop_no_ssl_verify         = true
    onprem_enabled            = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    publish_lb                = false
    task_cpu                  = 256
    task_memory               = 512
  }
}

variable "datastore_settings" {
  type = map(string)
  default = {
    enabled                   = true
    service_name              = "rookout-datastore"
    server_mode               = "PLAIN"
    cors_all                  = true
    in_memory_db              = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    task_cpu                  = 512
    task_memory               = 1024
  }
}
