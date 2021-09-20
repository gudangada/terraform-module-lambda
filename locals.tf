locals {
  service_name        = var.service_name == "" ? var.product_domain : format("%s-%s", var.product_domain, var.service_name)
  function_name       = format("%s-lambda-%s-%s", local.service_name, var.function_name, var.environment)
  default_description = format("%s %s lambda function", local.service_name, var.environment)
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
}