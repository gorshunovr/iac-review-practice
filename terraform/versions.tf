terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }

  backend "s3" {
    bucket         = "orders-platform-tfstate"
    key            = "orders/prod/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "orders-platform-tflock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = { project = "orders", owner = "platform", managed_by = "terraform" }
  }
}
