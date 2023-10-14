terraform {
  required_version = ">= 1.0.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "cloudflare" {
  api_token = var.cloudflare_global_api_token
}