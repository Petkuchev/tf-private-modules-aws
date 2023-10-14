data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringLike"
      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:*:*"]
    }
    principals {
      identifiers = [module.eks.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

### ALB ###

data "http" "alb_controller_policy_json" {
  count = var.alb_controller.role_enabled ? 1 : 0

  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/${var.alb_controller.version}/docs/install/iam_policy.json"
  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_iam_role" "alb_controller_role" {
  count = var.alb_controller.role_enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  name               = "${var.cluster_name}_alb_controller_role"
  tags               = var.tags
}

resource "aws_iam_policy" "alb_controller_policy" {
  count = var.alb_controller.role_enabled ? 1 : 0

  name        = "${var.cluster_name}_alb_controller_policy"
  description = "Policy for access from alb controller from ${var.cluster_name} cluster to ALB service"
  policy      = data.http.alb_controller_policy_json[0].response_body

  tags = merge(
    var.tags,
    { alb_version = var.alb_controller.version }
  )
}

resource "aws_iam_role_policy_attachment" "alb_controller_policy_attach" {
  count = var.alb_controller.role_enabled ? 1 : 0

  role       = aws_iam_role.alb_controller_role[0].id
  policy_arn = aws_iam_policy.alb_controller_policy[0].arn
}

###

### EXTERNAL_DNS ###

resource "aws_iam_role" "external_dns_role" {
  count = var.external_dns_role_enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  name               = "${var.cluster_name}_external_dns_role"
  tags               = var.tags
}

resource "aws_iam_policy" "external_dns_policy" {
  count = var.external_dns_role_enabled ? 1 : 0

  name        = "${var.cluster_name}_external_dns_policy"
  description = "Route 53 policy for ExternalDNS usage from ${var.cluster_name} cluster"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "route53:ChangeResourceRecordSets"
        ],
        Resource : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        Effect : "Allow",
        Action : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        Resource : [
          "*"
        ]
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "external_dns_policy_attach" {
  count = var.external_dns_role_enabled ? 1 : 0

  role       = aws_iam_role.external_dns_role[0].id
  policy_arn = aws_iam_policy.external_dns_policy[0].arn
}

###

### EBS CSI DRIVER ROLE ###

resource "aws_iam_role" "eks_ebs_cni_role" {
  count = var.ebs_cni_role_enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  name               = "${var.cluster_name}_eks_ebs_csi_role"
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_ebs_cni_policy_attach" {
  count = var.ebs_cni_role_enabled ? 1 : 0

  role       = aws_iam_role.eks_ebs_cni_role[0].id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

###

### QREDOCHAIN ROLE ###

resource "aws_iam_role" "qredochain_role" {
  count = var.qredochain_role_enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  name               = "${var.cluster_name}_qredochain_role"
  tags               = var.tags
}

resource "aws_iam_policy" "qredochain_policy" {
  count = var.qredochain_role_enabled ? 1 : 0

  name        = "${var.cluster_name}_qredochain_policy"
  description = "Access policy from ${var.cluster_name} to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "s3:Get*",
          "s3:List*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ],
        Resource : [
          "arn:aws:s3:::qredochain-mainnet-snapshots/*",
          "arn:aws:s3:::qredochain-mainnet-snapshots",
          "arn:aws:s3:::qredochain-mainnet-genesis/*",
          "arn:aws:s3:::qredochain-testnet-genesis/*",
          "arn:aws:s3:::qredochain-testnet-snapshots",
          "arn:aws:s3:::qredochain-testnet-snapshots/*",
          "arn:aws:s3:::qredochain-devnet-snapshots",
          "arn:aws:s3:::qredochain-devnet-snapshots/*",
          "arn:aws:s3:::qredochain-devnet-keys/genesis.json",
          "arn:aws:s3:::${var.genesis_s3_bucket_name}",
          "arn:aws:s3:::${var.genesis_s3_bucket_name}/genesis.json"
        ]
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "qredochain_policy_attach" {
  count = var.qredochain_role_enabled ? 1 : 0

  role       = aws_iam_role.qredochain_role[0].id
  policy_arn = aws_iam_policy.qredochain_policy[0].arn
}

###

#### ECR POLICIES ####

resource "aws_iam_policy" "ecr_access_policy" {
  for_each = var.ecr_registries

  name        = "${var.cluster_name}_${each.key}_ecr_access_policy"
  description = "Policy to provide push and pull access to ECR ecr:${each.key}:${each.value}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ],
        Resource : [
          "arn:aws:ecr:${each.key}:${each.value}:repository/*"
        ]
      }
    ]
  })
  tags = var.tags
}


resource "aws_iam_policy" "node_group_policy" {
  for_each = var.iam_node_role_additional_policies

  name        = "${var.cluster_name}_${each.key}"
  description = each.value.description
  policy      = jsonencode(each.value.policy_body)
  tags        = var.tags
}
