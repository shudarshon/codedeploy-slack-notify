provider "aws" {
  region  = "${var.aws_region}"
}

################################################################################
## Terraform Remote Backend
################################################################################

terraform {
  backend "s3" {
    bucket = "codedeploy-slack-notify-lambda"
    key    = "lambda/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

################################################################################
## Terraform Remote Data Source for IAM
################################################################################

data "terraform_remote_state" "shared_iam" {
  backend = "s3"
  config {
    bucket = "codedeploy-slack-notify-lambda"
    key    = "iam/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
  }
}

################################################################################
## Terraform Remote Data Source for KMS
################################################################################

data "terraform_remote_state" "shared_kms" {
  backend = "s3"
  config {
    bucket = "codedeploy-slack-notify-lambda"
    key    = "kms/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
  }
}