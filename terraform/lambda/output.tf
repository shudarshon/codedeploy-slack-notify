output "lambda-codedeploy-slack-notify-role-arn" {
  value = "${aws_lambda_function.codedeploy_slack_notify_lambda_function.*.arn}"
}
