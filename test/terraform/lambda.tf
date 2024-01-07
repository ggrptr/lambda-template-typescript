
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lambda_layer_version" "node_modules" {
  for_each = var.lambda.additional_layers
  layer_name = each.key
  filename = each.value
  source_code_hash = sha256(each.value)
}


resource "aws_lambda_function" "test" {
  depends_on = [aws_cloudwatch_log_group.lambda_log_group]

  function_name = var.lambda.function_name
  role = aws_iam_role.test_lambda_role.arn

  filename = var.lambda.package
  runtime = var.lambda.runtime
  handler = var.lambda.handler
  memory_size = var.lambda.memory_size
  timeout = var.lambda.timeout
  source_code_hash = sha256(var.lambda.package)
  layers = [for layer in aws_lambda_layer_version.node_modules : layer.id]

  environment {
    variables = {
      }
    }
}

output "lambda" {
  value = aws_lambda_function.test
}