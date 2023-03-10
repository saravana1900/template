# Provider details for KMS

provider "aws" {
  region = "REGION"
}

terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    region = "TF_BUCKET_REGION"
    key    = "CLIENT_NAME/kms/terraform.tfstate"

  }
}
