variable "vpc_id" {
  description = "VPC ID for deployment"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for deployment"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for deployment"
  type        = list(string)
}

variable "default_vpc" {
  description = "Set true if you want to use default VPC or VPC without private networks."
  type    = bool
  default = false
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

variable "certificate_arn" {
  description = "AWS ACM Certificate ARN to attach to load balancer"
  type        = string
  default     = null
}

variable "certificate_bucket_name" {
  description = "AWS S3 bucket name where certificates will be located. Automatically set datastore ROOKOUT_DOP_SERVER_MODE variable to TLS"
  type        = string
  default     = null
}

variable "certificate_bucket_prefix" {
  description = "AWS S3 bucket prefix where certificates will be located if datastore in TLS mode"
  type        = string
  default     = null
}

variable "prviate_namespace_name" {
  description = "Name for AWS CloudMap namespace used for service discovery"
  type    = string
  default = "cluster.local"
}

variable "tags" {
  description = "Additional tags for deployment"
  type    = map(string)
  default = {}
}