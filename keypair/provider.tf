
provider "aws" {
  region = "REGION"
}

terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    region = "TF_BUCKET_REGION"
    key    = "CLIENT_NAME/keypair/terraform.tfstate"

  }
}
