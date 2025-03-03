terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
  required_version = ">=1.2.4"
}

provider "aws" {
  alias  = "eu_west_1"
  region = "eu-west-1"
}