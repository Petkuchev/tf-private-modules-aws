module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"


  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  kms_key_administrators = var.kms_key_administrators

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = aws_iam_role.eks_ebs_cni_role[0].arn
    }
  }

  vpc_id                    = var.vpc_id
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  subnet_ids                = var.private_subnets

  cluster_identity_providers = {
    for key, value in var.cluster_identity_providers : value.name => {
      client_id                     = value.client_id
      identity_provider_config_name = value.identity_provider_config_name
      issuer_url                    = value.issuer_url
      username_claim                = value.username_claim
      username_prefix               = value.username_prefix
      groups_prefix                 = value.groups_prefix
      required_claims               = value.required_claims
      groups_claim                  = value.groups_claim
      AzureGroupID                  = value.AzureGroupID
    }
  }

  cluster_security_group_additional_rules = var.cluster_security_group_additional_rules
  node_security_group_additional_rules    = var.node_security_group_additional_rules
  cloudwatch_log_group_retention_in_days  = var.cloudwatch_log_group_retention_in_days
  cluster_enabled_log_types               = var.cluster_enabled_log_types

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    for key, value in var.node_groups : value.name => {
      min_size                     = value.min_size
      max_size                     = value.max_size
      desired_size                 = value.desired_size
      key_name                     = value.key_name
      instance_types               = value.instance_types
      capacity_type                = value.capacity_type
      ami_type                     = value.ami_type
      iam_role_additional_policies = { for policy_name, policy in merge(aws_iam_policy.ecr_access_policy, aws_iam_policy.node_group_policy) : policy_name => policy.arn }
      labels                       = value.labels
      use_name_prefix              = value.use_name_prefix
      pre_bootstrap_user_data      = try(coalesce(var.node_groups_user_data[value.name]), "")
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = value.disk_size
            volume_type = "gp3"
          }
        }
      }
    }
  }

  create_aws_auth_configmap = var.create_aws_auth_configmap
  manage_aws_auth_configmap = var.manage_aws_auth_configmap
  aws_auth_roles            = var.aws_auth_roles
  aws_auth_users            = var.aws_auth_users


  tags = var.tags
}
