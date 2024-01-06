data "local_file" "lambda_packages" {
  for_each = toset(["src", "node_modules"])
  filename = "/dist/${each.value}.zip"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${local.lambda_function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lambda_layer_version" "node_modules" {
  layer_name = "node_modules"
  filename = data.local_file.lambda_packages["node_modules"].filename
}


resource "aws_lambda_function" "test" {
  depends_on = [aws_cloudwatch_log_group.lambda_log_group]

  function_name = local.lambda_function_name
  role = aws_iam_role.test_lambda_role.arn

  filename = data.local_file.lambda_packages["src"].filename
  runtime = "nodejs20.x"
  handler = "main.handler"
  memory_size = 128
  timeout = 5
  source_code_hash = sha256(data.local_file.lambda_packages["src"].filename)
  layers = [aws_lambda_layer_version.node_modules.id]

  environment {
    variables = {
      }
    }
}


output "lambda" {
  value = aws_lambda_function.test
}