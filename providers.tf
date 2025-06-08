terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "5.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1" # Set your desired region
}

provider "vault" {
  # Add configuration if needed
}