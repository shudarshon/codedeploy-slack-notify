################################################################################
## SSM KMS KEY
################################################################################

resource "aws_kms_key" "KMS_LAMBDA" {
  description             = "KMS key for LAMBDA function parameter encryption"
  deletion_window_in_days = 14
}