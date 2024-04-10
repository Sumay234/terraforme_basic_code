
provider "aws" {
  region = "us-east-1" # Set your desired region here
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.stack_name}-LambdaRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    "Lambda Function Name" = "${var.stack_name}-LambdaFunction"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.stack_name}-LambdaPolicy"
  path        = "/"
  description = "Policy for Lambda function"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudWatchLogsPermissions",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:${data.aws_partition.current.partition}:logs:*:*:*"
    },
    {
      "Sid": "LambdaFunctionPermissionsforSNSPublish",
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": "${aws_sns_topic.notify_topic.arn}" 
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "${var.stack_name}-LambdaFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "hello-python.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
  s3_bucket        = var.lambda_zip_bucket
  s3_key           = var.lambda_zip_key
  filename         = "${path.module}/hello-python.zip"
  depends_on      = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
 # source_code_hash = filebase64sha256(hello-python)

  environment {
    variables = {
      outbound_topic_arn = aws_sns_topic.notify_topic.arn
      logging_level      = var.logging_level
    }
  }

  tags = {
    "Lambda Function Name" = "${var.stack_name}-LambdaFunction"
  }
}

resource "aws_cloudwatch_event_rule" "config_event_rule" {
  name        = "CreateIAMUserEventRule"
  description = "Event rule to trigger evaluation"
  event_pattern = <<EOF
{
  "source": ["aws.iam"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["iam.amazonaws.com"],
    "eventName": ["CreateUser"]
  }
}
EOF

  depends_on = [aws_lambda_function.lambda_function]

  tags = {
    Name = "CreateIAMUserEventRule"
  }
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.config_event_rule.name
  target_id = "LambdaFunctionTarget"
  arn       = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.config_event_rule.arn

  depends_on = [aws_cloudwatch_event_rule.config_event_rule]
}

resource "aws_sns_topic" "notify_topic" {
  name = "SecurityControlNotifications"
}

resource "aws_sns_topic_subscription" "notify_subscription" {
  topic_arn = aws_sns_topic.notify_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}
/*
data "aws_partition" "current" {}
# Generates an archive from content, a file, or a directory of files.
*/

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/hello-python/"
 output_path = "${path.module}/hello-python/hello-python.zip"
}

