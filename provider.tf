terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
        
    }

    backend "s3" {
      bucket = "roboshop-statefile-bucket"
      key = "roboshop-project-dev/terraform.state"
      region="us-east-1"
    }
}

provider "aws" {
    region = "us-east-1"
}
