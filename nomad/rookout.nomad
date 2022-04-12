
variable "datacenter" {
  ## set the `NOMAD_VAR_datacenter` environment variable to override
  type = list(string)
  default = ["dc1"]
}

variable "driver" {
  ## set the `NOMAD_VAR_driver` environment variable to override
  type = string
  default = "docker"
}

variable "rookout_token" {
  ## set the `NOMAD_VAR_rookout_token` environment variable to override
  type = string
  default = ""
}

variable "controller_settings" {
  type = map(string)
  default = {
    count             = 1
    dop_no_ssl_verify = "true"
    server_mode       = "PLAIN"
    cpu               = "256"
    mem               = "512"
    cert_path         = null
    key_path          = null
  }
}

variable "datastore_settings" {
  type = map(string)
  default = {
    count        = 1
    in_memory_db = "true"
    server_mode  = "PLAIN"
    cpu          = "256"
    mem          = "512"
    cert_path    = null
    key_path     = null
  }
}

locals {
  controller_cert = var.controller_settings.cert_path == null ? "none" : file(var.controller_settings.cert_path)
  controller_key  = var.controller_settings.key_path == null ? "none" : file(var.controller_settings.key_path)
  datastore_cert = var.datastore_settings.cert_path == null ? "none" : file(var.datastore_settings.cert_path)
  datastore_key  = var.datastore_settings.key_path == null ? "none" : file(var.datastore_settings.key_path)
  datastore_port = var.datastore_settings.server_mode == "TLS" ? 4343 : 8080
}

job "rookout" {
  datacenters = var.datacenter
  type        = "service"

  group "controller" {
    count = var.controller_settings.count

    network {
      port "websocket" {
        static = 7488
      }
    }

    // Uncomment for Consul discovery
    //
    // service {
    //   name = "rookout-controller"
    //   port = "websocket"

    //   check {
    //     type     = "http"
    //     path     = "/"
    //     interval = "30s"
    //     timeout  = "5s"
    //   }
    // }

    task "controller" {
      driver = var.driver

      config {
        image   = "rookout/controller:latest"
        mounts = [{
          type     = "bind"
          source   = "secrets"
          target   = "/var/controller-tls-secrets"
          readonly = true
        }]
        ports   = ["websocket"]
      }

      env {
        ROOKOUT_DOP_NO_SSL_VERIFY      = var.controller_settings.dop_no_ssl_verify
        ROOKOUT_CONTROLLER_SERVER_MODE = var.controller_settings.server_mode
      }
      
      // It is advised to use Vault integration can be used in token and certificate templates
      // RefDoc: https://www.nomadproject.io/docs/integrations/vault-integration

      template {
        data = <<EOH
ROOKOUT_TOKEN="${var.rookout_token}"
EOH
        destination = "${NOMAD_SECRETS_DIR}/file.env"
        env         = true
      }

      template {
        data          = local.controller_cert
        destination   = "${NOMAD_SECRETS_DIR}/tls.crt"
        change_mode   = "restart"
      }

      template {
        data = local.controller_key
        destination   = "${NOMAD_SECRETS_DIR}/tls.key"
        change_mode   = "restart"
      }

      resources {
        cpu    = var.controller_settings.cpu
        memory = var.controller_settings.mem
      }
    }
  }

  group "datastore" {

    count = var.datastore_settings.count

    network {
      port "http" {
        static = local.datastore_port
      }
    }

    // Uncomment for Consul discovery
    //
    // service {
    //   name = "rookout-datastore"
    //   port = "http"

    //   check {
    //     type     = "http"
    //     path     = "/healthz"
    //     interval = "30s"
    //     timeout  = "5s"
    //   }
    // }

    task "datastore" {
      driver = var.driver

      config {
        image   = "rookout/data-on-prem:latest"
        mounts = [{
          type     = "bind"
          source   = "secrets"
          target   = "/var/rookout"
          readonly = true
        }]
        ports   = ["http"]
      }

      env {
        ROOKOUT_DOP_IN_MEMORY_DB  = var.datastore_settings.in_memory_db
        ROOKOUT_DOP_SERVER_MODE   = var.datastore_settings.server_mode
      }

      // It is advised to use Vault integration can be used in token and certificate templates
      // RefDoc: https://www.nomadproject.io/docs/integrations/vault-integration

      template {
        data = <<EOH
ROOKOUT_DOP_LOGGING_TOKEN="${var.rookout_token}"
EOH
        destination = "${NOMAD_SECRETS_DIR}/file.env"
        env         = true
      }

      template {
        data          = local.datastore_cert
        destination   = "${NOMAD_SECRETS_DIR}/cert.pem"
        change_mode   = "restart"
      }

      template {
        data          = local.datastore_key
        destination   = "${NOMAD_SECRETS_DIR}/key.pem"
        change_mode   = "restart"
      }

      resources {
        cpu    = var.datastore_settings.cpu
        memory = var.datastore_settings.mem
      }
    }
  }
}