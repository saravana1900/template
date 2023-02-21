provider "aws" {
  region = "TF_BUCKET_REGION"
}

terraform {
  backend "s3" {
    bucket  = "BUCKET_NAME"
    region  = "TF_BUCKET_REGION"
    key     = "CLIENT_NAME/s3/terraform.tfstate"
   
  }
}
