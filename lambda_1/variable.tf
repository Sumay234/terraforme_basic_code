
variable "stack_name" {
  description = "Name of the CloudFormation stack"
  type        = string
}

variable "lambda_zip_bucket" {
  description = "Name of the S3 Bucket"
  type        = string
}

variable "lambda_zip_key" {
  description = "The file key name"
  type        = string
}

variable "logging_level" {
  description = "Lambda Logging level"
  type        = string
}

variable "notification_email" {
  description = "Email address to alert of any security control violations"
  type        = string
}
