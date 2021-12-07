variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "availability_zones_names" {
  description = "Names of Availability Zones with subnets (a minimum of 2 is needed for ALB)"
  type        = list(string)
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
variable "name_prefix" {
  description = "Name prefix to use in all created resources"
  type        = string
  default     = "dev"
}
variable "datastore_server_mode" {
  description = "Server mode (AUTOTLS/TLS/PLAIN) for Rookout Datastore"
  type        = string
  default     = "PLAIN"
}
