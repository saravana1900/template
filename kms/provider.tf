# Provider details for KMS

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    region = "REGION"
    key    = "CLIENT_NAME/kms/terraform.tfstate"

  }
}
