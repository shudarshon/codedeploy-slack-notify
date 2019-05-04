provider "aws" {
  region  = "${var.aws_region}"
}

################################################################################
## Terraform Remote Backend
################################################################################

terraform {
  backend "s3" {
    bucket = "carbangla-codedeploy-slack-notify-lambda"
    key    = "cloudwatch/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

################################################################################
## Terraform Remote Data Source for Lambda
################################################################################

data "terraform_remote_state" "shared_lambda" {
  backend = "s3"
  config {
    bucket = "carbangla-codedeploy-slack-notify-lambda"
    key    = "lambda/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
  }
}
