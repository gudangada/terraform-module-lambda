locals {
  function_name       = replace(format("%s-%s-lambda-%s-%s", var.product_domain, var.service_name, var.function_name, var.environment), "--", "-")
  default_description = format("%s %s %s lambda function", var.product_domain, var.service_name, var.environment)
  description         = var.description == "" ? local.default_description : format("%s to %s", local.default_description, var.description)
  default_tags = {
    Name          = local.function_name
    Service       = var.service_name
    ProductDomain = var.product_domain
    Environment   = var.environment
    Description   = local.description
    ManagedBy     = "terraform"
  }
  tags = var.tags == {} ? local.default_tags : merge(local.default_tags, var.tags)

  # apigateway variable
  use_api_gateway = var.use_api_gateway ? 1 : 0
}
