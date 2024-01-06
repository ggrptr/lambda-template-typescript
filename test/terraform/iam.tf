data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "log_access" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.lambda_function_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "test_lambda_role" {
  name_prefix = local.lambda_function_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

}

resource "aws_iam_policy" "test_lambda_policy" {
  name_prefix = local.lambda_function_name
  policy = data.aws_iam_policy_document.log_access.json
}

resource "aws_iam_role_policy_attachment" "lambda_log_access" {
  policy_arn = aws_iam_policy.test_lambda_policy.arn
  role       = aws_iam_role.test_lambda_role.name
}
