terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  # temporarily local while we sort out state locking permissions
  backend "local" {}
}

provider "aws" {
  region = var.region
  default_tags {
    tags = { project = "orders", owner = "platform", managed_by = "terraform" }
  }
}
