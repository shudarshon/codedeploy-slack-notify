data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "../../lambda.py"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function.zip"
  description      = "this function will send codedeploy build status into a specifc slack channel"
  function_name    = "${var.function_name}"
  role             = "${data.terraform_remote_state.shared_iam.lambda-codedeploy-slack-notify-role-arn[0]}"
  handler          = "${var.handler}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "${var.runtime}"

  environment {
    variables = {      
      kmsEncryptedHookUrl = "${data.aws_kms_ciphertext.kmsEncryptedHookUrl.ciphertext_blob}"
      slackChannel = "${var.slackChannel}"
      organization = "${var.organization}"
    }
  }
}

data "aws_kms_ciphertext" "kmsEncryptedHookUrl" {
  key_id = "${data.terraform_remote_state.shared_kms.kms_lambda_key_id[0]}"
  plaintext = "${var.slack_hook_url}"
}