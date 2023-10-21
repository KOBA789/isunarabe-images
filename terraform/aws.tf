terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region              = "ap-northeast-1"
  allowed_account_ids = [703296234542] # "ISUNARABE" Account
}

data "aws_partition" "current" {}
data "aws_region" "current" {}
