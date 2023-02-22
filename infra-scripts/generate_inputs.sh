#!/usr/bin/env bash


update_file(){
   
   env=${1}
   client=${2}
   region=${3}
   tf_b=${4}
   tf_b_reg=${5}

   # Updating Tf state bucket region value
    
   sed -i "s/TF_BUCKET_REGION/$tf_b_reg/g" ../iam/*.tfvars ../iam/*.tf  
   sed -i "s/TF_BUCKET_REGION/$tf_b_reg/g" ../kms/*.tfvars ../kms/*.tf  
   sed -i "s/TF_BUCKET_REGION/$tf_b_reg/g" ../kms/terraform.tfvars ../kms/provider.tf 
   sed -i "s/TF_BUCKET_REGION/$tf_b_reg/g" ../s3/*.tfvars ../s3/*.tf

   # Updating tfstate bucket value
   sed -i "s/BUCKET_NAME/$tf_b/g" ../iam/*.tfvars ../iam/*.tf ../keypair/*.tfvars ../keypair/*.tf
   sed -i "s/BUCKET_NAME/$tf_b/g" ../kms/*.tfvars ../kms/*.tf ../s3/*.tfvars ../s3/*.tf
   
   # Updating deployment region value

   sed -i "s/REGION/$region/g" ../iam/*.tfvars ../iam/*.tf ../keypair/*.tfvars ../keypair/*.tf 
   sed -i "s/REGION/$region/g" ../kms/*.tfvars ../kms/*.tf ../s3/*.tfvars ../s3/*.tf

   # Updating deployment Client Name value

   sed -i "s/CLIENT_NAME/$client/g" ../iam/*.tfvars ../iam/*.tf 
   sed -i "s/CLIENT_NAME/$client/g" ../keypair/*.tfvars ../keypair/*.tf 
   sed -i "s/CLIENT_NAME/$client/g" ../kms/*.tfvars ../kms/*.tf 
   sed -i "s/CLIENT_NAME/$client/g"  ../s3/*.tfvars ../s3/*.tf

   # Updating deployment environment (dev/prod) value

   sed -i "s/ENV_TYPE/$region/g" ../iam/terraform.tfvars ../keypair/terraform.tfvars
   sed -i "s/ENV_TYPE/$region/g" ../kms/terraform.tfvars ../s3/terraform.tfvars
   
   



}

env=${1}
client=${2}
region=${3}
vpc_range=${4}
run_type=${5}
tf_bucket_dev="dev-tfm-state"
tf_bucket_prod="dev-tfm-prod-state"
tf_bucket_region_dev="us-east-1"
tf_bucket_region_prod="ca-central-1"


if [ $# -ne 5 ] 
then 
    echo "Not enough Parameters"
else
    echo "Environment           : ${1}"
    echo "Client Name           : ${2}"
    echo "Deployment Region     : ${3}"
    echo "VPC Cidr Range        : ${4}"
    echo "Terraform Run Type    : ${5}"

    if [ $env == "dev" ]
    then
        update_file $env $client $region $tf_bucket_dev $tf_bucket_region_dev

    elif [ $env == "prod" ]
    then
        update_file $env $client $region $tf_bucket_dev $tf_bucket_region_dev
        
    fi


fi


