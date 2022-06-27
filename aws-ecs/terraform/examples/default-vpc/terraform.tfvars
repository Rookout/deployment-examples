vpc_id                 = "vpc-xxxxxxx"
public_subnets         = ["subnet-xxxxxxx", "subnet-xxxxxxx"]
default_vpc            = true
create_lb              = true
region                 = "us-east-1"
rookout_token_arn      = "arn:aws:secretsmanager:xx-xxxx-x:xxxxxxxxxxxxxx:secret:rookout-token-xxxxxxx"
environment            = "dev"
prviate_namespace_name = "cluster.local"
controller_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  certificate_bucket_prefix = "certs-controller"
  certificate_bucket_name   = "bucket-xxxxxx-us-east-1"
  certificate_arn           = null
  publish_lb                = true
}
datastore_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  certificate_bucket_prefix = "certs-datastore"
  certificate_bucket_name   = "bucket-xxxxxx-us-east-1"
  certificate_arn           = null
  publish_lb                = true
}
