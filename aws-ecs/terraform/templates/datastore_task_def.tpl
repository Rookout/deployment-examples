[
  {
    "name": "${name}",
    "image": "rookout/data-on-prem:latest",
    "cpu": ${cpu},
    "memory": ${memory},
    "memoryReservation": ${memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080
      }
    ],
    "environment": [
      {
        "name": "ROOKOUT_DOP_SERVER_MODE",
        "value": "${datastore_server_mode}"
      },
      {
        "name": "ROOKOUT_DOP_CORS_ALL",
        "value": "${datastore_cors_all}"
      },
      {
        "name": "ROOKOUT_DOP_IN_MEMORY_DB",
        "value": "${datastore_in_memory_db}"
      }
    ],
    "secrets": [
      {
        "name": "ROOKOUT_DOP_LOGGING_TOKEN",
        "valueFrom": "${rookout_token_arn}"
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
  }
]