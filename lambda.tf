resource "aws_lambda_function" "lambda" {
  filename      = "aircall-node.zip"
  function_name = "function-fileupload-francisco"
  runtime       = "nodejs16.x"
  handler       = "app.lambdaHandler"
  role          = aws_iam_role.lambda_iam.arn

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.b.id
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.api_gw.execution_arn}/*/*"
}
