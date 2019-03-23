output "kms_lambda_key_id" {
  value = "${aws_kms_key.KMS_LAMBDA.*.key_id}"
}
