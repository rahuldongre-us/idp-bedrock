# verify aws config is setup
provider "aws" {
  region = var.region
}

locals {
  aws_resource_name = "${var.name_prefix}-${random_string.name.id}-${var.environment}"
  model_name        = "anthropic.claude-3-haiku-20240307-v1:0"
  zip_file_name     = "lambda_function_payload.zip"
  file_name         = "scanned-doc.jpeg"
}

resource "aws_s3_bucket" "idp-bedrock" {
  bucket = local.aws_resource_name
}

resource "aws_s3_object" "upload_file" {
  bucket = local.aws_resource_name
  key    = local.file_name         # The name it will have in S3
  source = "../${local.file_name}" # Local path to the file
  etag   = filemd5("../${local.file_name}")

  tags = {
    Name        = local.aws_resource_name
    Environment = var.environment
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = local.aws_resource_name
  description = "IAM policy for IDP Lambda"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "arn:aws:s3:::${local.aws_resource_name}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "bedrock:InvokeModel"
        ],
        Resource = "arn:aws:bedrock:*::foundation-model/${local.model_name}"
      }
    ]
  })
}

// Define the IAM role that the Lambda function will assume
resource "aws_iam_role" "lambda_role" {
  name = local.aws_resource_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

// Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "idp_bedrock_lambda" {
  function_name = local.aws_resource_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "idp_lambda_processor.lambda_handler"
  runtime       = "python3.13"
  architectures = ["arm64"]
  timeout       = "60"

  filename         = "../${local.zip_file_name}"
  source_code_hash = filebase64sha256("../${local.zip_file_name}")

  environment {
    variables = {
      ENV_NAME    = "production"
      DEBUG       = "false"
      BUCKET_NAME = local.aws_resource_name
      MODEL_NAME  = local.model_name
      REGION_NAME = var.region
      FILE_NAME   = local.file_name
    }
  }
}
