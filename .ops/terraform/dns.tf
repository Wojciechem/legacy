resource "cloudflare_dns_record" "cf" {
  zone_id  = var.CF_ZONE_ID
  name     = "cf"
  proxied  = true
  content = "188.245.161.37"
  type     = "A"
  ttl      = 1
}

resource "cloudflare_dns_record" "kodzik" {
  zone_id  = var.CF_ZONE_ID
  name     = "kodzik.cloud"
  proxied  = true
  content = "188.245.161.37"
  type     = "A"
  ttl      = 1
}