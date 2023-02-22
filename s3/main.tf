data "terraform_remote_state" "kms_info" {
    backend = "s3"
    config = {
        bucket = "BUCKET_NAME"
	key = "CLIENT_NAME/kms/terraform.tfstate"
        region = "REGION"
    }
}


resource "aws_s3_bucket" "bucket0" {
  bucket 		  = "${var.resource_tag}devs3artifacts"
  acl    		  = "private"
  force_destroy 	  = false
  

  server_side_encryption_configuration {
    rule {
      	apply_server_side_encryption_by_default {
        	kms_master_key_id = data.terraform_remote_state.kms_info.outputs.kms_key_arn[0]
        	sse_algorithm     = "aws:kms"
      		}
    	}
  }
  tags = {
    Name		  = "${var.resource_tag}devs3artifacts"
    client 		  = var.client
    env 		  = var.env
    region	          = var.region
    env-purpose 	  = var.env-purpose
    category 		  = var.category
    fincode 		  = var.fincode
    v3ops-custom-tag	  = var.v3ops-custom-tag
    terraform 		  = path.cwd
  }
}
resource "aws_s3_bucket_public_access_block" "bucket0" {
  bucket = aws_s3_bucket.bucket0.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
output "bucket0_id" {
    value = aws_s3_bucket.bucket0.id
}
output "bucket0_arn" {
    value = aws_s3_bucket.bucket0.arn
}
