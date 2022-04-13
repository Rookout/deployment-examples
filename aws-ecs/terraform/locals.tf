locals {
  default_controller_settings = {
    enabled                   = true
    service_name              = "rookout-controller"
    serer_mode                = "PLAIN"
    dop_no_ssl_verify         = true
    onprem_enabled            = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    publish_lb                = false
    task_cpu                  = 256
    task_memory               = 512
    container_cpu             = 256
    container_memory          = 512
  }
  default_datastore_settings = {
    enabled                   = true
    service_name              = "rookout-datastore"
    serer_mode                = "PLAIN"
    cors_all                  = true
    in_memory_db              = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    task_cpu                  = 512
    task_memory               = 1024
    container_cpu             = 256
    container_memory          = 512
    storage_size              = 20
  }
  controller_settings = merge(local.default_controller_settings, var.controller_settings)
  datastore_settings  = merge(local.default_datastore_settings, var.datastore_settings)

  name_prefix            = format("%s-%s", var.environment, var.service)
  cluster_name           = var.cluster_name != null ? var.cluster_name : format("%s-cluster", local.name_prefix)
  create_cluster         = var.cluster_name != null ? false : true
  task_subnets           = var.default_vpc ? var.public_subnets : var.private_subnets
  datastore_server_mode  = local.datastore_settings.server_mode
  datastore_publish_lb   = var.create_lb && local.datastore_settings.publish_lb && local.datastore_settings.enabled ? true : false
  datastore_volumes      = local.datastore_server_mode == "TLS" ? [{ name = "certs" }] : []
  datastore_port         = local.datastore_server_mode == "TLS" ? 4343 : 8080
  datastore_lb_protocol  = local.datastore_settings.certificate_arn != null && local.datastore_publish_lb ? "HTTPS" : "HTTP"
  datastore_tg_protocol  = local.datastore_settings.server_mode == "TLS" ? "HTTPS" : "HTTP"
  datastore_storage      = local.datastore_settings.storage_size > 20 ? [local.datastore_settings.storage_size] : []
  controller_server_mode = local.controller_settings.server_mode
  controller_publish_lb  = var.create_lb && local.controller_settings.publish_lb && local.controller_settings.enabled ? true : false
  controller_volumes     = local.controller_server_mode == "TLS" ? [{ name = "certs" }] : []
  controller_lb_protocol = local.controller_settings.certificate_arn != null && local.controller_publish_lb ? "HTTPS" : "HTTP"
  controller_tg_protocol = local.controller_server_mode == "TLS" ? "HTTPS" : "HTTP"

  load_balancer_controller = local.controller_publish_lb ? [{
    target_group_arn = try(aws_lb_target_group.controller[0].arn, null)
    container_name   = local.controller_settings.service_name
    container_port   = 7488
  }] : []
  load_balancer_datastore = local.datastore_publish_lb ? [{
    target_group_arn = try(aws_lb_target_group.datastore[0].arn, null)
    container_name   = local.datastore_settings.service_name
    container_port   = local.datastore_port
  }] : []

  tags = merge(var.tags, {
    Environment = var.environment
    Service     = var.service
  })
}