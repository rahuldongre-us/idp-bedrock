output "s3_bucket" {
  value = aws_s3_bucket.idp-bedrock.bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.idp_bedrock_lambda.function_name
}
