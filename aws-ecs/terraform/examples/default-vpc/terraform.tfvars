vpc_id                 = "vpc-0ddd4385198044b6f"
public_subnets         = ["subnet-0b24284913b02c8d8", "subnet-02b76d71542167f00"]
default_vpc            = true
create_lb              = true
region                 = "us-east-1"
aws_profile            = "opsfleet" 
rookout_token_arn      = "arn:aws:secretsmanager:us-east-1:782824484157:secret:rookout_token-JeQYA2"
environment            = "dev"
prviate_namespace_name = "cluster.local"
controller_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  certificate_bucket_prefix = "certs-controller"
  certificate_bucket_name   = "cf-templates-11x1qjid1uaq7-us-east-1"
  certificate_arn           = null
  publish_lb                = true
}
datastore_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  certificate_bucket_prefix = "certs"
  certificate_bucket_name   = "cf-templates-11x1qjid1uaq7-us-east-1"
  certificate_arn           = null
  publish_lb                = true
}
