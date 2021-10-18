# terraform-module-lambda

## Usage

### Lambda Function (store package locally)

```hcl
module "lambda_function" {
  source = "github.com/gudangada/terraform-module-lambda"
  function_name = "promo-engine"
  description   = "generate available promotions on marketplace."
  handler       = "main.handler"
  runtime       = "python3.8"
  lambda_role_arn       = "arn:aws:iam::123456789:role/service-role/your-role"
  vpc_subnet_ids        = ["10.0.84.0/24"]
  vpc_security_group_ids= ["sg-12345"]

  source_path = "../src/lambda-function"
  environment = "development"
  product_domain = "marketplace"
  service_name = "worker"
}
```

## Modules

- [terraform-aws-modules/lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest)
