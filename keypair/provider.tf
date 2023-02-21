
provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    region = "REGION"
    key    = "CLIENT_NAME/keypair/terraform.tfstate"

  }
}
