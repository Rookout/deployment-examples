output "alb_dns_name" {
  value = try(aws_lb.alb[0].dns_name, null)
}

output "controller_internal_dns_name" {
  value = format("%s.%s", aws_ecs_service.controller[0].name, var.prviate_namespace_name)
}

output "datastore_internal_dns_name" {
  value = format("%s.%s", aws_ecs_service.datastore[0].name, var.prviate_namespace_name)
}