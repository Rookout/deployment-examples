output "alb_dns_name" {
  value = try(aws_lb.alb[0].dns_name, null)
}

output "controller_private_endpoint" {
  value = local.controller_endpoint
}

output "datastore_private_endpoint" {
  value = local.datastore_endpoint
}