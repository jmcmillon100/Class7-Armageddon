terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# São Paulo (main)
provider "aws" {
  region = "sa-east-1"
}

# us-east-1 (for CloudFront ACM certs)
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}