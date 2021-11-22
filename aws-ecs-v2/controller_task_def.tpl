[
  {
    "name": "${name}",
    "image": "rookout/controller:latest",
    "cpu": ${cpu},
    "memory": ${memory},
    "memoryReservation": ${memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 7488
      }
    ],
    "environment": [
      {
        "name": "ROOKOUT_TOKEN",
        "value": "${rookout_token}"
      },
      {
        "name": "ROOKOUT_DOP_NO_SSL_VERIFY",
        "value": "true"
      },
      {
        "name": "ONPREM_ENABLED",
        "value": "true"
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