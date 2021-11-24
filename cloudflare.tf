# Cloudflare
resource "cloudflare_record" "record" {
  count   = local.use_api_gateway
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  value   = aws_api_gateway_domain_name.domain[0].cloudfront_domain_name
  type    = "CNAME"
  ttl     = 1 # Automatic
}
