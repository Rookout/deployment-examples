resource "aws_iam_role_policy" "logs_policy" {
  name = "logs-${local.deployment_id}"
  role = aws_iam_role.task_exec_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "secrets_policy" {
  name = "secrets-${local.deployment_id}"
  role = aws_iam_role.task_exec_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ],
        "Effect": "Allow",
        "Resource": "${var.rookout_token_arn}"
      }
    ]
  }
  EOF
}


resource "aws_iam_role_policy" "s3_controller" {
  count = local.controller_server_mode == "TLS" ? 1 : 0

  name = "s3-controller-${local.deployment_id}"
  role = aws_iam_role.task_exec_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::${local.controller_settings.certificate_bucket_name}",
          "arn:aws:s3:::${local.controller_settings.certificate_bucket_name}/*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "s3_datastore" {
  count = local.datastore_server_mode == "TLS" ? 1 : 0

  name = "s3-datastore-${local.deployment_id}"
  role = aws_iam_role.task_exec_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::${local.datastore_settings.certificate_bucket_name}",
          "arn:aws:s3:::${local.datastore_settings.certificate_bucket_name}/*"
        ]
      }
    ]
  }
  EOF
}



resource "aws_iam_role" "task_exec_role" {
  name = local.deployment_id

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}