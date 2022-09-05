#path - /terragrunt-ec2/dev/terragrunt.hcl

terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=4.0.0"
}


locals {
    env_vars = yamldecode(
    file("${find_in_parent_folders("common-environment.yaml")}"),
    )
}


#path - /terragrunt-ec2/dev/terragrunt.hcl

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  provider "aws" {
    profile = "consultlawal"
    region  = "us-east-1"
    # shared_credentials_file = "/Users/rwagh/credentials"
    # access_key = "<insert_your_access_key>"
    # secret_key = "<insert_your_secret_key>"
  }
EOF
}

#path - /terragrunt-ec2/dev/terragrunt.hcl

inputs = {
  ami           = "ami-0767046d1677be5a0"
  instance_type = local.env_vars.local.instance_type
  tags = {
    Name = "Terragrunt Tutorial: EC2"
  }
}

