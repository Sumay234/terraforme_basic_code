/*
provider "aws" {
  region = "us-east-1" # Set your desired region here
}

# Define the Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "MyLambdaFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.lambda_handler"
  runtime          = "python3.9"
  timeout          = 60
  memory_size      = 128
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  environment {
    variables = {
      # You can add environment variables here if needed
    }
  }
}

# IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })

  # Attach basic Lambda execution policy
  # For production use, customize this policy to adhere to the principle of least privilege
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

# IAM policy attachment for additional permissions (if needed)
# Example:
# resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
#   name       = "lambda_policy_attachment"
#   roles      = [aws_iam_role.lambda_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }


*/
