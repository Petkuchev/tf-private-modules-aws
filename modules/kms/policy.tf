################################################################################
# KMS POLICY 
################################################################################

data "aws_iam_policy_document" "kms-iam-policy-document" {
  statement {
    actions = var.kms_policy_actions
    resources = [
        aws_kms_key.kms-key.arn
        ]
  }
}

resource "aws_iam_policy" "iam-kms-policy" {
  name   = "${var.kms_name}-kms-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.kms-iam-policy-document.json
  tags = merge(var.common_tags, {
    Environment  = var.environment
    Application  = var.service_name
  })
}


# Attach policy to k8s role 
resource "aws_iam_role_policy_attachment" "iam-role-policy-attachment" {
  role        = "${var.service_name}"
  policy_arn  = aws_iam_policy.iam-kms-policy.arn
}


################################################################################
# KMS ROLE K8S
################################################################################

resource "aws_iam_role" "iam-role" {

  count = var.iam-role-for-service-accounts-eks ? 1 : 0

  name  = "${var.service_name}"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.oidc_provider_id}"
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          StringEquals : {
            "oidc.eks.${var.region}.amazonaws.com/id/${var.oidc_provider_id}:sub" : "system:serviceaccount:${var.k8s_service_account_namespace}:${var.service_name}"
          }
        }
      }
    ]
  })
  tags = merge(var.common_tags, {
    Environment               = var.environment
    Namespace_service_account = var.k8s_service_account_namespace
    Application               = var.service_name
  })
}