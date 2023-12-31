terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.0"
    }
  }
}


provider "aws" {
  region                      = lookup(var.region, terraform.workspace)
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_use_path_style = true
  endpoints {
    ec2 = "http://aws:4566"
    dynamodb = "http://aws:4566"
    s3 = "http://aws:4566"
  }
}
