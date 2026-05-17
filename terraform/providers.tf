# Defines Terraform and AWS provider requirements
terraform {

  # Required Terraform version
  required_version = ">= 1.5.0"

  required_providers {
    aws = {

      # AWS provider source
      source = "hashicorp/aws"

      # AWS provider version
      version = "~> 5.0"
    }
  }
}

# Configures the AWS provider
provider "aws" {

  # AWS region for infrastructure deployment
  region = var.aws_region

  default_tags {

    # Automatically applies tags to supported AWS resources
    tags = {
      Project     = var.project_name
      ManagedBy   = "Terraform"
      Environment = "Development"
    }
  }
}