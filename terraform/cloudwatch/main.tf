resource "aws_cloudwatch_event_rule" "codedeploy_slack_notify_cloudwatch_event_rule" {
  name        = "${var.rule_name}"
  description = "${var.rule_description}"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.codedeploy"
  ],
  "detail-type": [
    "CodeDeploy Deployment State-change Notification"
  ],
  "detail": {
    "state": [
      "FAILURE",
      "START",
      "STOP",
      "READY",
      "SUCCESS"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "codedeploy_slack_notify_lambda_function_event_target" {
  rule      = "${aws_cloudwatch_event_rule.codedeploy_slack_notify_cloudwatch_event_rule.name}"  
  arn = "${data.terraform_remote_state.shared_lambda.lambda-codedeploy-slack-notify-role-arn[0]}"
}