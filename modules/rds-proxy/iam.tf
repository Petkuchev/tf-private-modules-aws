resource "aws_iam_policy" "rds-proxy" {
  name        = var.iam_settings.policy_name
  path        = "/"
  description = var.iam_settings.policy_description

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:CreateSecret",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "secretsmanager:*",
            "Resource": [
                "${aws_secretsmanager_secret.rds-proxy.arn}"
            ]
        }
    ]
}
EOF
}

# Role https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "rds-proxy" {
  name                = var.iam_settings.role_name
  assume_role_policy  = data.aws_iam_policy_document.rds-proxy-assume-role.json
  managed_policy_arns = [aws_iam_policy.rds-proxy.arn]
}