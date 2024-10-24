terraform {
  required_providers {
    cloudamqp = {
      source  = "cloudamqp/cloudamqp"
      version = ">= 1.29.2, < 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}