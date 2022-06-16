output "alb_dns_name" {
  value = local.load_balancer_endpoint
}

output "controller_private_endpoint" {
  value = local.controller_endpoint
}

output "datastore_private_endpoint" {
  value = local.datastore_endpoint
}