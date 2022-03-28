vpc_id                 = "vpc-0ddd4385198044b6f"
public_subnets         = ["subnet-0b24284913b02c8d8", "subnet-02b76d71542167f00"]
default_vpc            = true
region                 = "us-east-1"
rookout_token_arn      = "arn:aws:secretsmanager:us-east-1:782824484157:secret:rookout_token-JeQYA2"
environment            = "dev"
prviate_namespace_name = "cluster.local"
cluster_name           = null
controller_settings = {
  enabled                   = true
  service_name              = "rookout-controller"
  server_mode               = "TLS"
  dop_no_ssl_verify         = true
  onprem_enabled            = true
  certificate_bucket_prefix = "certs-controller"
  certificate_bucket_name   = "cf-templates-11x1qjid1uaq7-us-east-1"
  certificate_arn           = null
  publish_lb                = false
  task_cpu                  = 512
  task_memory               = 1024
}
datastore_settings = {
  enabled                   = true
  service_name              = "rookout-datastore"
  server_mode               = "TLS"
  cors_all                  = true
  in_memory_db              = true
  certificate_bucket_prefix = "certs"
  certificate_bucket_name   = "cf-templates-11x1qjid1uaq7-us-east-1"
  certificate_arn           = null
  publish_lb                = false
  task_cpu                  = 512
  task_memory               = 1024
}