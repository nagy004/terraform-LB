terraform {
  backend "s3" {
    bucket = "lab3-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}