
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

# Generate Key Pair ssh for EC2 instace
locals {
  public_key_filename  = "${var.path}/${var.client}-dev-golden-key.pub"
  private_key_filename = "${var.path}/${var.client}-dev-golden-key.pem"
}

resource "tls_private_key" "algorithm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.resource_tag}-${var.vpc_name}-golden-key"
  public_key = tls_private_key.algorithm.public_key_openssh
}

resource "local_file" "public_key_openssh" {
  count           = var.path != "" ? 1 : 0
  content         = tls_private_key.algorithm.public_key_openssh
  filename        = local.public_key_filename
  file_permission = "0700"
}

resource "local_file" "private_key_pem" {
  count           = var.path != "" ? 1 : 0
  content         = tls_private_key.algorithm.private_key_pem
  filename        = local.private_key_filename
  file_permission = "0700"
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}
