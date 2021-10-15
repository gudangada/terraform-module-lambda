module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  version = "2.22.0"

  function_name          = local.function_name
  description            = local.description
  handler                = var.handler
  memory_size            = var.memory_size
  runtime                = var.runtime
  layers                 = var.layer_arns
  timeout                = var.timeout
  environment_variables  = var.environment_variables
  dead_letter_target_arn = var.dead_letter_target_arn
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids
  create_role            = false
  lambda_role            = var.lambda_role_arn
  tags                   = local.tags

  source_path = var.source_path
}
