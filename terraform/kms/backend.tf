provider "aws" {
  region  = "${var.aws_region}"
}

################################################################################
## Terraform Remote Backend
################################################################################

terraform {
  backend "s3" {
    bucket = "carbangla-codedeploy-slack-notify-lambda"
    key    = "kms/codedeploy-lambda-slack-notify.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
