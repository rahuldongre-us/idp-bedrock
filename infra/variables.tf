resource "random_string" "name" {
  length  = 16
  upper   = false
  special = false
}

variable "name_prefix" {
  description = "Prefix for the random name"
  type        = string
  default     = "idp-bedrock"
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "prod"
}