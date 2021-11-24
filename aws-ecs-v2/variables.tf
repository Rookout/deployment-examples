variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "region" {
  description = "AWS Region"
  type        = string
}
variable "rookout_token" {
  description = "Token of your Rookout organization"
  type        = string
}
variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}
variable "datastore_server_mode" {
  description = "Server mode (AUTOTLS/TLS/PLAIN) for Rookout Datastore"
  type        = string
  default     = "PLAIN"
}
