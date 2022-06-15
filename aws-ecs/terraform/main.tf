resource "random_id" "deployment" {
  prefix      = "${local.name_prefix}-"
  byte_length = 4
}

locals {
  default_controller_settings = {
    deploy                    = true
    container_name            = "rookout-controller"
    serer_mode                = "PLAIN"
    dop_no_ssl_verify         = true
    onprem_enabled            = true
    certificate_bucket_prefix = null
    certificate_bucket_name   = null
    certificate_arn           = null
    publish_lb                = false
    task_cpu                  = 512
    task_memory               = 1024
    container_cpu             = 256
    container_memory          = 512
    container_port            = 7488
    load_balancer_port        = 7488
  }
  default_datastore_settings = {
    deploy                    = true
    container_name            = "rookout-datastore"
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
    container_port            = 8080
    load_balancer_port        = 443
  }
  controller_settings = merge(local.default_controller_settings, var.controller_settings)
  datastore_settings  = merge(local.default_datastore_settings, var.datastore_settings)

  name_prefix            = format("%s-%s", var.environment, var.service)
  deployment_id          = random_id.deployment.hex
  datastore_name         = "datastore-${local.deployment_id}"
  controller_name        = "controller-${local.deployment_id}"
  lb_enable              = var.create_lb || var.existing_lb_arn != null ? true : false
  cluster_name           = var.cluster_name != null ? var.cluster_name : local.deployment_id
  create_cluster         = var.cluster_name != null ? false : true
  task_subnets           = var.default_vpc ? var.public_subnets : var.private_subnets
  datastore_server_mode  = local.datastore_settings.server_mode
  datastore_publish_lb   = local.lb_enable && local.datastore_settings.publish_lb && local.datastore_settings.deploy ? true : false
  datastore_volumes      = local.datastore_server_mode == "TLS" ? [{ name = "certs" }] : []
  datastore_port         = local.datastore_settings.container_port
  datastore_lb_port      = local.datastore_settings.load_balancer_port
  datastore_lb_protocol  = local.datastore_settings.certificate_arn != null && local.datastore_publish_lb ? "HTTPS" : "HTTP"
  datastore_tg_protocol  = local.datastore_settings.server_mode == "TLS" ? "HTTPS" : "HTTP"
  datastore_storage      = local.datastore_settings.storage_size > 20 ? [local.datastore_settings.storage_size] : []
  datastore_definition   = templatefile((local.datastore_server_mode == "TLS" ? "${path.module}/templates/datastore_tls_task_def.tpl" : "${path.module}/templates/datastore_task_def.tpl"), {
    name                      = local.datastore_settings.container_name
    cpu                       = local.datastore_settings.container_cpu
    memory                    = local.datastore_settings.container_memory
    port                      = local.datastore_port
    log_group                 = aws_cloudwatch_log_group.rookout.name
    log_stream                = aws_cloudwatch_log_stream.datastore_log_stream[0].name
    aws_region                = var.region
    rookout_token_arn         = var.rookout_token_arn
    datastore_server_mode     = local.datastore_settings.server_mode
    datastore_cors_all        = local.datastore_settings.cors_all
    datastore_in_memory_db    = local.datastore_settings.in_memory_db
    certificate_bucket_name   = try(local.datastore_settings.certificate_bucket_name, "none")
    certificate_bucket_prefix = try(local.datastore_settings.certificate_bucket_prefix, "none")
  })
  datastore_endpoint = format("%s://%s.%s:%s", aws_service_discovery_service.datastore[0].name, var.prviate_namespace_name, local.datastore_port, lower(local.datastore_tg_protocol))
  load_balancer_datastore = local.datastore_publish_lb ? [{
    target_group_arn = try(aws_lb_target_group.datastore[0].arn, null)
    container_name   = local.datastore_settings.container_name
    container_port   = local.datastore_port
  }] : []

  controller_server_mode = local.controller_settings.server_mode
  controller_publish_lb  = local.lb_enable && local.controller_settings.publish_lb && local.controller_settings.deploy ? true : false
  controller_volumes     = local.controller_server_mode == "TLS" ? [{ name = "certs" }] : []
  controller_port        = local.controller_settings.container_port
  controller_lb_port     = local.controller_settings.load_balancer_port
  controller_lb_protocol = local.controller_settings.certificate_arn != null && local.controller_publish_lb ? "HTTPS" : "HTTP"
  controller_tg_protocol = local.controller_server_mode == "TLS" ? "HTTPS" : "HTTP"
  controller_definition = templatefile((local.controller_server_mode == "TLS" ? "${path.module}/templates/controller_tls_task_def.tpl" : "${path.module}/templates/controller_task_def.tpl"), {
    name                      = local.controller_settings.container_name
    cpu                       = local.controller_settings.container_cpu
    memory                    = local.controller_settings.container_memory
    port                      = local.controller_port
    log_group                 = aws_cloudwatch_log_group.rookout.name
    log_stream                = aws_cloudwatch_log_stream.controller_log_stream[0].name
    aws_region                = var.region
    rookout_token_arn         = var.rookout_token_arn
    controller_server_mode    = local.controller_settings.server_mode
    onprem_enabled            = local.controller_settings.onprem_enabled
    dop_no_ssl_verify         = local.controller_settings.dop_no_ssl_verify
    certificate_bucket_name   = try(local.controller_settings.certificate_bucket_name, "none")
    certificate_bucket_prefix = try(local.controller_settings.certificate_bucket_prefix, "none")
  })
  controller_endpoint = format("%s://%s.%s:%s", aws_service_discovery_service.controller[0].name, var.prviate_namespace_name, local.controller_port, lower(local.controller_tg_protocol))
  load_balancer_controller = local.controller_publish_lb ? [{
    target_group_arn = try(aws_lb_target_group.controller[0].arn, null)
    container_name   = local.controller_settings.container_name
    container_port   = local.controller_port
  }] : []
  
  load_balancer_arn = var.existing_lb_arn != null && var.create_lb != true ? var.existing_lb_arn : try(aws_lb.alb[0].arn, null)
  tags = merge(var.tags, {
    Environment = var.environment
    Service     = var.service
  })
}