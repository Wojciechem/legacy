terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }

  required_version = ">= 1.2.0"
}

variable "HETZNER_API_KEY" {
  sensitive = true
}

variable "CF_API_KEY" {
  sensitive = true
}

variable "CF_ZONE_ID" {
  sensitive = true
}

variable "CF_ACCOUNT_ID" {
  sensitive = true
}

provider "hcloud" {
  token = var.HETZNER_API_KEY
}

provider "cloudflare" {
  api_token = var.CF_API_KEY
}
