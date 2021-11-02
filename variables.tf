###########
# Function
###########
variable "function_name" {
  description = "A unique name for Lambda Function in product domain. The actual lambda function name will be combined with product domain and environment."
  type        = string
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.8"
}

variable "lambda_role_arn" {
  description = " IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
}

variable "description" {
  description = "Description of your Lambda Function (or Layer)"
  type        = string
  default     = ""
}

variable "layer_arns" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = null
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 512
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 30
}

variable "dead_letter_target_arn" {
  description = "The ARN of an SNS topic or SQS queue to notify when an invocation fails."
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

##########################
# Build artifact settings
##########################
variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = any # string | list(string | map(any))
  default     = null
}

##########################
# GudangAda settings
##########################
variable "environment" {
  description = "development/staging/production"
  type        = string
}

variable "product_domain" {
  description = "Name of the product domain."
  type        = string
}

variable "service_name" {
  description = "Name of the service. Mostly used for naming along with product_domain and environment."
  type        = string
  default     = ""
}

##########################
# APIGateway settings
##########################
variable "use_api_gateway" {
  description = "To provision api gateway for proxy http request to lambda"
  type    = bool
  default = false
}

variable "domain_name" {
  description = "The domain name that you want use based on domain cert and cloudflare zone id"
  type = string
  default = null
}

variable "domain_cert" {
  description = "Domain certificate to validate your domain name"
  type = string
  default = null
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone id"
  type = string
  default = null
}
