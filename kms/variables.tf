variable "region" { default = "us-east-1" }
variable "env_flag" { default = "" }
variable "client" { default = "" }
variable "env-purpose" { default = "" }
variable "env" { default = "" }
variable "category" { default = "" }
variable "fincode" { default = "" }
variable "tf_state" { default = "" }
variable "ticket" { default = "" }
variable "owner" { default = "" }
variable "resource_tag" { default = "" }
variable "prod" {
  type = map
  default = {
    env         = " "
    env-purpose = " "
    category    = " "
    fincode     = " "
    ticket      = " "
    owner       = " "
  }
}
variable "non-prod" {
  type = map
  default = {
    env         = " "
    env-purpose = " "
    category    = " "
    fincode     = " "
    ticket      = " "
    owner       = " "
  }
}
variable "dev" {
  type = map
  default = {
    env         = " "
    env-purpose = " "
    category    = " "
    fincode     = " "
    ticket      = " "
    owner       = " "
  }
}


variable tf_state_bucket_region        { default =  }
