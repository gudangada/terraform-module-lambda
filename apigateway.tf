resource "random_id" "agw-name" {
  count       = local.use_api_gateway
  byte_length = 8
}

resource "aws_api_gateway_rest_api" "api-gateway" {
  count = local.use_api_gateway

  name = format("%s-%s-agw-%s", var.product_domain, var.service_name, var.environment)

  binary_media_types = [
    "*/*"
  ]

  tags = {
    Service       = var.service_name
    ProductDomain = var.product_domain
    Environment   = var.environment
    Description   = format("%s %s api gateway %s", var.product_domain, var.service_name, var.environment)
    ManagedBy     = "terraform"
  }
}

resource "aws_api_gateway_resource" "proxy-resource" {
  count       = local.use_api_gateway
  rest_api_id = aws_api_gateway_rest_api.api-gateway[0].id
  parent_id   = aws_api_gateway_rest_api.api-gateway[0].root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy-method" {
  count         = local.use_api_gateway
  rest_api_id   = aws_api_gateway_rest_api.api-gateway[0].id
  resource_id   = aws_api_gateway_resource.proxy-resource[0].id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda-integration" {
  count       = local.use_api_gateway
  rest_api_id = aws_api_gateway_rest_api.api-gateway[0].id
  resource_id = aws_api_gateway_method.proxy-method[0].resource_id
  http_method = aws_api_gateway_method.proxy-method[0].http_method
  credentials = aws_iam_role.api-gateway-role[0].arn

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_function.lambda_function_invoke_arn
}

resource "aws_api_gateway_domain_name" "domain" {
  count           = local.use_api_gateway
  certificate_arn = var.domain_cert
  domain_name     = var.domain_name

  tags = {
    Service       = var.service_name
    ProductDomain = var.product_domain
    Environment   = var.environment
    ManagedBy     = "terraform"
  }
}

resource "aws_api_gateway_deployment" "stage" {
  count           = local.use_api_gateway
  rest_api_id     = aws_api_gateway_rest_api.api-gateway[0].id
  stage_name      = var.environment
  security_policy = var.security_policy

  depends_on = [
    aws_api_gateway_method.proxy-method,
    aws_api_gateway_integration.lambda-integration
  ]
}

resource "aws_api_gateway_base_path_mapping" "mapping" {
  count       = local.use_api_gateway
  api_id      = aws_api_gateway_rest_api.api-gateway[0].id
  stage_name  = aws_api_gateway_deployment.stage[0].stage_name
  domain_name = aws_api_gateway_domain_name.domain[0].domain_name
}
