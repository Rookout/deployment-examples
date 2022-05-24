[
  {
    "name": "s3-downloader",
    "image": "amazon/aws-cli:latest",
    "cpu": 128,
    "memory": 128,
    "essential": false,
    "command": ["s3","sync", "s3://${certificate_bucket_name}/${certificate_bucket_prefix}", "/var/controller-tls-secrets"],
    "mountPoints": [
      {
        "containerPath": "/var/controller-tls-secrets",
        "sourceVolume": "certs"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${log_group}",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "${log_stream}"
        }
    }
  },
  {
    "name": "${name}",
    "image": "rookout/controller:latest",
    "cpu": ${cpu},
    "memory": ${memory},
    "memoryReservation": ${memory},
    "essential": true,
    "dependsOn": [
      {
        "condition": "SUCCESS",
        "containerName": "s3-downloader"
      }
    ],
    "portMappings": [
      {
        "containerPort": ${port}
      }
    ],
    "environment": [
      {
        "name": "ROOKOUT_DOP_NO_SSL_VERIFY",
        "value": "${dop_no_ssl_verify}"
      },
      {
        "name": "ONPREM_ENABLED",
        "value": "${onprem_enabled}"
      },
      {
        "name": "ROOKOUT_CONTROLLER_SERVER_MODE",
        "value": "${controller_server_mode}"
      }
    ],
    "secrets": [
      {
        "name": "ROOKOUT_TOKEN",
        "valueFrom": "${rookout_token_arn}"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/var/controller-tls-secrets",
        "sourceVolume": "certs"
      }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${log_group}",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "${log_stream}"
        }
    },
    "healthCheck": {
        "retries": 3,
        "command": [
            "CMD-SHELL",
            "wget http://localhost:4009/healthz -O /dev/null || exit 1"
        ],
        "timeout": 5,
        "interval": 30,
        "startPeriod": null
    }
  }
]