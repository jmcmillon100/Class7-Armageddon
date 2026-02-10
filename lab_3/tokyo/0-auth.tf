terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Tokyo (main)
provider "aws" {
  region = "ap-northeast-1"
}

# us-east-1 (CloudFront ACM certs + CloudFront-scope WAF)
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}