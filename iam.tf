data "aws_iam_policy_document" "api-gateway-assume-policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "api-gateway-lambda-policy" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]

    effect = "Allow"
    resources = [
      module.lambda_function.lambda_function_arn
    ]
  }
}

resource "aws_iam_role" "api-gateway-role" {
  count              = local.use_api_gateway
  name               = format("%s-%s-%s-agw-role", var.product_domain, var.service_name, var.environment)
  assume_role_policy = data.aws_iam_policy_document.api-gateway-assume-policy.json

  inline_policy {
    name   = "lambda-policy"
    policy = data.aws_iam_policy_document.api-gateway-lambda-policy.json
  }
}
