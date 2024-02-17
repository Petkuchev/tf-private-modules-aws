resource "aws_cloudwatch_log_data_protection_policy" "this" {
  log_group_name = aws_cloudwatch_log_group.redis.name
  policy_document = jsonencode({
    Name    = "logs_data_protection_redis"
    Version = "2021-06-01"

    Statement = [
      {
        Sid            = "Audit"
        DataIdentifier = ["arn:aws:dataprotection::aws:data-identifier/EmailAddress"]
        Operation = {
          Audit = {
            FindingsDestination = {
              S3 = {
                Bucket = aws_s3_bucket.redis_logs.bucket
              }
            }
          }
        }
      },
      {
        Sid            = "Redact"
        DataIdentifier = ["arn:aws:dataprotection::aws:data-identifier/EmailAddress"]
        Operation = {
          Deidentify = {
            MaskConfig = {}
          }
        }
      }
    ]
  })
}