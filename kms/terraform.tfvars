region          = "us-east-1"
env_flag        = "ENV_TYPE"
client          = "CLIENT_NAME"
resource_tag    = "CLIENT_NAME"
tf_state_bucket = "BUCKET_NAME"
non-prod = {
  client      = "CLIENT_NAME"
  env         = "non-prod"
  env-purpose = "security"
  category    = "support"
  fincode     = "-v3host"
  owner       = "infosec"
  ticket      = "vcs-"
}
prod = {
  client      = "CLIENT_NAME"
  env         = "prod"
  env-purpose = "security"
  category    = "support"
  fincode     = "-v3host"
  owner       = "infosec"
  ticket      = "vcs-"
}

dev = {
  client      = "CLIENT_NAME"
  env         = "not-applicable"
  env-purpose = "security"
  category    = "support"
  fincode     = "-v10"
  owner       = "infosec"
  ticket      = "vcs-"
}



tf_state_bucket_region  = "TF_BUCKET_REGION"
