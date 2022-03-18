variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "Subnet ID"
  type        = list(string)
}

variable "private_subnets" {
  description = "Subnet ID"
  type        = list(string)
}

variable "default_vpc" {
  type    = bool
  default = false
}

variable "create_lb" {
  description = "Set to true if you want to publish services publically via Application Load Balancer"
  type        = bool
  default     = false
}

variable "publish_controller_lb" {
  type   = bool
  default = false
}

variable "datastore_server_mode" {
  type = string
  default = "PLAIN"
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "rookout_token_arn" {
  description = "Token of your Rookout organization"
  type        = string
}

variable "cluster_name" {
  description = "Cluster Name"
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
  description = "AWS S3 bucket name where certificates will be located if datastore use native TLS mode"
  type        = string
  default     = ""
}

variable "certificate_bucket_prefix" {
  description = "AWS S3 bucket prefix where certificates will be located if datastore use native TLS mode"
  type        = string
  default     = ""
}

variable "prviate_namespace_name" {
  type    = string
  default = "cluster.local"
}