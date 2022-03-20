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
  description = ""
  type        = bool
  default     = false
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

variable "certificate_arn" {
  description = "AWS ACM Certificate ARN to attach to load balancer"
  type        = string
  default     = null
}

variable "certificate_bucket_name" {
  description = "AWS S3 bucket name where certificates will be located if datastore use native TLS mode"
  type        = string
  default     = null
}

variable "certificate_bucket_prefix" {
  description = "AWS S3 bucket prefix where certificates will be located if datastore use native TLS mode"
  type        = string
  default     = null
}

variable "prviate_namespace_name" {
  type    = string
  default = "cluster.local"
}