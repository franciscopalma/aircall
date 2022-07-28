resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [
    "aws_lambda_function.lambda"
  ]
}

resource "aws_cloudwatch_log_stream" "foo" {
  name           = "lambda-fileupload-logstream"
  log_group_name = aws_cloudwatch_log_group.function_log_group.name
}
