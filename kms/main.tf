

resource "aws_kms_key" "key" {
  count               = var.env_flag == "dev" ? 1 : 0
  description         = "Use for encrypting non production instances and surrounding services for ${var.client} VPC"
  enable_key_rotation = true
  tags = merge(
    {
      Name        = "v3d-${var.resource_tag}-nonprod-${var.region}",
      client      = var.client,
      env         = var.dev["env"],
      env-purpose = var.dev["env-purpose"],
      category    = var.dev["category"],
      fincode     = var.dev["fincode"],
      owner       = var.dev["owner"],
      ticket      = var.dev["ticket"],
      terraform   = path.cwd
    }
  )
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "key-consolepolicy-3",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow access for Key Administrators",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::277959858025:user/awsdemo"
        ]
      },
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::277959858025:role/demo"
         
        ]
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow attachment of persistent resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::277959858025:role/demo"
       
        ]
      },
      "Action": [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": "true"
        }
      }
    }
  ]
}
EOF
}
resource "aws_kms_alias" "alias2" {
  count         = var.env_flag == "dev" ? 1 : 0
  name          = "alias/v3d-${var.client}-nonprod-${var.region}"
  target_key_id = aws_kms_key.key[0].key_id
}




