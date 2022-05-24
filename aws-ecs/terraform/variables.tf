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
  default     = false
}

variable "create_lb" {
  description = "Set to true if you want to publish services publicly via Application Load Balancer"
  type        = bool
  default     = false
}

variable "existing_lb_arn" {
  description = "Set ALB ARN if you want to use existing Application Load Balancer for chosen deployment."
  type        = string
  default     = null
}

variable "launch_type" {
  description = "Launch type for ECS Services. Set to EC2 if you've provided cluster_name variable with existing EC2 cluster name."
  type        = string
  default     = "FARGATE"
}

variable "controller_settings" {
  type = map(string)
  default = {
    deploy                    = true
    container_name            = "rookout-controller"
    server_mode               = "PLAIN"
    dop_no_ssl_verify         = true
    onprem_enabled            = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    publish_lb                = false
    task_cpu                  = 512
    task_memory               = 1024
    container_cpu             = 256
    container_memory          = 512
    container_port            = 7488
    load_balancer_port        = 7488
  }
}

variable "datastore_settings" {
  type = map(string)
  default = {
    deploy                    = true
    container_name            = "rookout-datastore"
    server_mode               = "PLAIN"
    cors_all                  = true
    in_memory_db              = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    publish_lb                = true
    task_cpu                  = 512
    task_memory               = 1024
    container_cpu             = 256
    container_memory          = 512
    storage_size              = 20
    container_port            = 8080
    load_balancer_port        = 443
  }
}

variable "publish_controller_lb" {
  description = "Set true if you want to publish controller trough LoadBalancer. create_lb parameter should be set to true."
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

variable "service" {
  description = "Service name, will be set as part of local.name_prefix"
  type        = string
  default     = "rookout"
}

variable "prviate_namespace_name" {
  description = "Name for AWS CloudMap namespace used for service discovery"
  type        = string
  default     = "cluster.local"
}

variable "tags" {
  description = "Additional tags for deployment"
  type        = map(string)
  default     = {}
}