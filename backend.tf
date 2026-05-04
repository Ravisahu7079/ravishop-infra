terraform {
  backend "s3" {
    bucket = "ravishop-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}
