output "aws_iam_user0_secret" {
  value = aws_iam_access_key.user_key0.encrypted_secret
}