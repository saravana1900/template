

#S3 state files

data "terraform_remote_state" "kms_info" {
    backend = "s3"
    config = {
        bucket = "BUCKET_NAME"
	key = "CLIENT_NAME/kms/terraform.tfstate"
        region = "REGION"
    }
}


resource "aws_iam_user" "user0" {
  name = "${var.resource_tag}devs3service"
  path = "/system/"
}
resource "aws_iam_access_key" "user_key0" {
  user    = aws_iam_user.user0.name
}
resource "aws_iam_user_policy" "user0_kms" {
  name = "${aws_iam_user.user0.name}-kms-policy"
  user = aws_iam_user.user0.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt"
      ],
      "Effect": "Allow",
      "Resource": "${data.terraform_remote_state.kms_info.outputs.kms_key_arn[0]}"
    }
  ]
}
EOF
}
resource "aws_iam_user_policy" "user0_artifact" {
  name = "${aws_iam_user.user0.name}-s3artifact-policy"
  user = aws_iam_user.user0.name

  policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
		{
		"Sid": "VisualEditor0",
		"Effect": "Allow",
		"Action": [
			"s3:PutAccountPublicAccessBlock",
			"s3:GetAccountPublicAccessBlock",
			"s3:ListAllMyBuckets",
			"s3:ListJobs",
			"s3:CreateJob",
			"s3:HeadBucket"
		],
		"Resource": "*"
		},
		{
		"Sid": "VisualEditor1",
		"Effect": "Allow",
		"Action": "s3:*",
		"Resource": [
			"${data.terraform_remote_state.s3_info.outputs.bucket0_arn}",
			"${data.terraform_remote_state.s3_info.outputs.bucket0_arn}/*"
		]
		}
		]
}
EOF
}

