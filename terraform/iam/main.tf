data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "lambda-assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codedeploy-lambda-slack-notify" {
  statement {
      effect = "Allow",
      actions = [
          "kms:Decrypt"
      ]
      resources = [
          "*"
      ]
  }
  statement {
      effect = "Allow",
      actions = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
      ]
      resources = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      ]
  }
}

resource "aws_iam_role" "lambda-codedeploy-slack-notify-role" {
  name = "${var.iam_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.lambda-assume.json}"
  force_detach_policies = true
}

resource "aws_iam_role_policy" "lambda-codedeploy-slack-notify-policy" {
  name = "${var.iam_policy_name}"
  role = "${aws_iam_role.lambda-codedeploy-slack-notify-role.id}"
  policy = "${data.aws_iam_policy_document.codedeploy-lambda-slack-notify.json}"
}
