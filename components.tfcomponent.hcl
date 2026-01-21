# Parent/Upstream Stack - VPC Configuration
# This stack represents a VPC managed by platform admins.
# It doesn't actually provision infrastructure.

variable "account_id" {
  description = "Cloud provider account ID"
  type        = string
}

variable "region" {
  description = "Cloud provider region"
  type        = string
}


required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }
}

provider "random" "this" {}

component "vpc" {

  source = "./vpc"

  inputs = {
    account_id = var.account_id
    region = var.region
  }

  providers = {
    random = provider.random.this
  }
}

output "vpc_id" {
  value = component.vpc.vpc_id.id
  type = string
}

output "subnet_private_id" {
  value = component.vpc.subnet_private_id.id
  type = string
}

output "subnet_public_id" {
  value = component.vpc.subnet_public_id.id
  type = string
}

output "repro_null" {
  value = null
  type  = string
}
