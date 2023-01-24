terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "4.51.0"
#     }
#   }
# }

# provider "aws" {
#   region = var.region
# }