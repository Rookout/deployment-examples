output "alb_dns_name" {
  value = try(aws_lb.alb[0].dns_name, null)
}

output "controller_private_endpoint" {
  value = format("%s.%s:%s", aws_service_discovery_service.controller[0].name, var.prviate_namespace_name, local.controller_port)
}

output "datastore_private_endpoint" {
  value = format("%s.%s:%s", aws_service_discovery_service.datastore[0].name, var.prviate_namespace_name, local.datastore_port)
}