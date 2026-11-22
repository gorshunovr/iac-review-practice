variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "queue_names" {
  type    = list(string)
  default = ["order-created", "order-paid", "order-shipped"]
}

variable "vpc_id" {
  type        = string
  description = "VPC created by the CDK OrdersShared stack"
}

variable "alb_security_group_id" {
  type = string
}

variable "db_password" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}
