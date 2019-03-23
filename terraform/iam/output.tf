output "lambda-codedeploy-slack-notify-role-arn" {
  value = "${aws_iam_role.lambda-codedeploy-slack-notify-role.*.arn}"
}
