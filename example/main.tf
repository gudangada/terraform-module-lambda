module "lambda_function" {
  source = "../"

  function_name          = "unique-code-generator"
  description            = "generate transaction unique code on payment."
  handler                = "main.handler"
  runtime                = "python3.8"
  lambda_role_arn        = "arn:aws:iam::123456789:role/service-role/your-role"
  vpc_subnet_ids         = ["10.0.84.0/24"]
  vpc_security_group_ids = ["sg-12345"]

  source_path    = "./lambda-function"
  environment    = "development"
  product_domain = "payment"
  service_name   = "worker"

  # Optional if you want to use api gateway that can proxy lambda from http request
  use_api_gateway    = true
  domain_name        = "payment-example.gudangada.online"
  domain_cert        = "arn:aws:acm:us-east-1:708503013607:certificate/386552a3-c743-4dd9-97fe-ffde5bdbbd21" # please use us-east-1__central-acm-dev outputs acm_arn
  cloudflare_zone_id = "dcb71cc9c6efeb6eacbed1805cc3b5f8"                                                    # Zone ID: gudangada.online

  cwl_retention_in_days = 60
}
