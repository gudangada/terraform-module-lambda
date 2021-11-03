# terraform-module-lambda
## Depencies
This Terraform module uses another Terraform module, here is the list of Terraform module dependencies:
- [terraform-aws-modules/lambda](https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest)

## Requirements
| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers
| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |
| [cloudflare](#provider\_cloudflare) | n/a |

## How to remove
### With API Gateway
* Set `use_api_gateway=false`
* `terraform apply`