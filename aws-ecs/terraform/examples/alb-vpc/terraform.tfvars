private_cidrs          = ["10.0.1.0/24", "10.0.2.0/24"]
public_cidrs           = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_cidr               = "10.0.0.0/16"
azs                    = ["us-east-1a", "us-east-1b"]
create_lb              = true
region                 = "us-east-1"
rookout_token_arn      = "arn:aws:secretsmanager:xx-xxxx-x:xxxxxxxxxxxxxx:secret:rookout-token-xxxxxxx"
environment            = "dev"
prviate_namespace_name = "cluster.local"
controller_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  dop_no_ssl_verify         = true
  onprem_enabled            = true
  certificate_bucket_prefix = "certs-controller"
  certificate_bucket_name   = "bucket-xxxxxx-us-east-1"
  certificate_arn           = "arn:aws:acm:xx-xxxx-x:xxxxxxxxxxxxxx:certificate/xxxxxxxx-xxxxxx-xxxxx-xxxxxx-xxxxx"
  publish_lb                = false
}
datastore_settings = {
  deploy                    = true
  server_mode               = "PLAIN"
  certificate_bucket_prefix = "certs-datastore"
  certificate_bucket_name   = "bucket-xxxxxx-us-east-1"
  certificate_arn           = "arn:aws:acm:xx-xxxx-x:xxxxxxxxxxxxxx:certificate/xxxxxxxx-xxxxxx-xxxxx-xxxxxx-xxxxx"
  publish_lb                = true
}
