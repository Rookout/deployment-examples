locals {
  name_prefix           = format("%s-%s", var.environment, var.service)
  cluster_name          = format("%s-cluster", local.name_prefix)
  create_cluster        = var.cluster_name != null ? false : true
  task_subnets          = var.default_vpc ? var.public_subnets : var.private_subnets
  datastore_server_mode = var.certificate_bucket_name != null ? "TLS" : "PLAIN"
  datastore_volumes     = var.datastore_server_mode == "TLS" ? ["certs"] : []
  datastore_port        = var.certificate_arn != null ? 4343 : 8080
  datastore_lb_protocol = var.certificate_arn != null ? "HTTPS" : "HTTP"

  load_balancer_controller = var.create_lb != false ? null : [{
    target_group_arn = try(aws_lb_target_group.controller[0].arn, null)
    container_name   = "rookout-controller"
    container_port   = 7488
  }]
  load_balancer_datastore = var.create_lb != false ? [] : [{
    target_group_arn = try(aws_lb_target_group.datastore[0].arn, null)
    container_name   = "rookout-datastore"
    container_port   = 8080
  }]

  tags = {
    Environment = var.environment
    Service     = var.service
  }
}