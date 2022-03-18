resource "aws_iam_role_policy" "task_exec_role_policy_logs" {
  name = "${local.name_prefix}-rookout_role_logs_policy"
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

resource "aws_iam_role_policy" "task_exec_role_policy_secrets" {
  name = "${local.name_prefix}-rookout_role_secrets_policy"
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


resource "aws_iam_role_policy" "task_exec_role_policy_s3" {
  count = var.datastore_server_mode == "TLS" ? 1 : 0

  name = "${local.name_prefix}-rookout_role_s3_policy"
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
          "arn:aws:s3:::${var.certificate_bucket_name}",
          "arn:aws:s3:::${var.certificate_bucket_name}/*",
        ]
      }
    ]
  }
  EOF
}



resource "aws_iam_role" "task_exec_role" {
  name = "${local.name_prefix}-exec-role"

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