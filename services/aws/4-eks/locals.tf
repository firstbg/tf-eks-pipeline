locals {
  terraform_assume_role_name = "Administrator"

  eks_master_iam_role_policy_description = format(
    "%s %s %s %s",
    lower(var.eks_cluster_resource_prefix),
    lower(var.environment_name),
    lower(var.eks_master_tier_name),
    "node IAM role policy"
  )

  eks_master_iam_assume_role_policy_document_statements = [
    {
      sid       = "0"
      effect    = "Allow"
      actions   = ["sts:AssumeRole"]
      resources = []
      condition = [
        {
          test     = ""
          variable = ""
          values   = []
        }
      ]
      principals = [
        {
          type        = "Service"
          identifiers = ["eks.amazonaws.com"]
        }
      ]
    }
  ]

  eks_master_iam_role_policy_attachments = list(
    # module.eks_master_iam_role_policy.arn,
    data.aws_iam_policy.amazon_eks_cluster_policy.arn,
    data.aws_iam_policy.amazon_eks_service_policy.arn,
  )

  eks_master_kms_key_policy_document_statements = [
    {
      sid    = "Allow access through EBS for all principals in the account that are authorized to use EBS"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:CreateGrant",
        "kms:DescribeKey"
      ]
      resources = ["*"]
      condition = [
        {
          test     = "StringEquals"
          variable = "kms:ViaService"
          values   = [data.aws_region.current.endpoint]
        },
        {
          test     = "StringEquals"
          variable = "kms:CallerAccount"
          values   = [data.aws_caller_identity.current.account_id]
        }
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
    },
    {
      sid    = "Allow direct access to key metadata to the account"
      effect = "Allow"
      actions = [
        "kms:Describe*",
        "kms:Get*",
        "kms:List*",
        "kms:RevokeGrant"
      ]
      resources = ["*"]
      condition = [
        {
          test     = "StringEquals"
          variable = "kms:CallerAccount"
          values   = [data.aws_caller_identity.current.account_id]
        }
      ]
      principals = [
        {
          type = "AWS"
          identifiers = [
            format(
              "%s%s%s",
              "arn:aws:iam::",
              data.aws_caller_identity.current.account_id,
              ":root"
            )
          ]
        }
      ]
    },
    {
      sid    = "Allow access for key administrators"
      effect = "Allow"
      actions = [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ]
      resources = ["*"]
      condition = [
        {
          test     = ""
          variable = ""
          values   = []
        }
      ]
      principals = [
        {
          type = "AWS"
          identifiers = [
            format(
              "%s%s%s",
              "arn:aws:iam::",
              data.aws_caller_identity.current.account_id,
              ":role/Administrator"
            ),
            format(
              "%s%s%s",
              "arn:aws:iam::",
              data.aws_caller_identity.current.account_id,
              ":root"
            )
          ]
        },
      ]
    },
    {
      sid    = "Allow use of the key"
      effect = "Allow"
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ]
      resources = ["*"]
      condition = [
        {
          test     = "StringEquals"
          variable = "kms:CallerAccount"
          values   = [data.aws_caller_identity.current.account_id]
        }
      ]
      principals = [
        {
          type = "AWS"
          identifiers = [
            format(
              "%s%s%s%s",
              "arn:aws:iam::",
              data.aws_caller_identity.current.account_id,
              ":role/",
              module.eks_master_iam_role.name,
            )
          ]
        }
      ]
    },
    {
      sid    = "Allow attachment of persistent resources"
      effect = "Allow"
      actions = [
        "kms:CreateGrant",
        "kms:ListGrants",
        "kms:RevokeGrant"
      ]
      resources = ["*"]
      condition = [
        {
          test     = "Bool",
          variable = "kms:GrantIsForAWSResource",
          values   = ["true"]
        }
      ]
      principals = [
        {
          type = "AWS"
          identifiers = [
            format(
              "%s%s%s%s",
              "arn:aws:iam::",
              data.aws_caller_identity.current.account_id,
              ":role/",
              module.eks_master_iam_role.name
            )
          ]
        }
      ]
    }
  ]

  eks_master_kms_key_description = format(
    "%s %s %s %s",
    lower(var.eks_cluster_resource_prefix),
    lower(var.environment_name),
    lower(var.eks_master_tier_name),
    "node kms key."
  )

  eks_master_kms_key_usage = "ENCRYPT_DECRYPT"

  eks_common_security_group_ingress_rules = [
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = []
      self            = true
      description     = "Allow all K8S nodes to communicated with themselves."
    },
  ]

  eks_master_security_group_ingress_rules = concat(
    var.eks_master_security_group_custom_ingress_rules,
    local.eks_common_security_group_ingress_rules,
  )

  eks_master_security_group_egress_rules = concat(
    [
      {
        from_port       = 1025
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
        self            = false
        description     = "Allow cluster egress access to the Internet."
      },
    ],
    var.eks_master_security_group_custom_egress_rules
  )

  eks_worker_iam_assume_role_policy_document_statements = [
    {
      sid    = "0"
      effect = "Allow"
      actions = [
        "sts:AssumeRole",
      ]
      resources = []
      condition = [
        {
          test     = ""
          variable = ""
          values   = []
        },
      ]
      principals = [
        {
          type = "Service"
          identifiers = [
            "ec2.amazonaws.com"
          ]
        }
      ]
    }
  ]

  eks_worker_autoscaling_iam_role_policy_document_statements = [
    {
      sid    = "EKSWorkerAutoscalingAll"
      effect = "Allow"
      actions = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "ec2:DescribeLaunchTemplateVersions",
      ]
      resources = ["*"]
      condition = [
        {
          test     = ""
          variable = ""
          values   = []
        },
      ]
      principals = [
        {
          type        = ""
          identifiers = []
        }
      ]
    },
    {
      sid    = "EKSWorkerAutoscalingOwn"
      effect = "Allow"
      actions = [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "autoscaling:UpdateAutoScalingGroup",
      ]
      resources = ["*"]
      condition = [
        {
          test = "StringEquals"
          variable = format(
            "%s%s",
            "autoscaling:ResourceTag/kubernetes.io/cluster/",
            # module.eks_master_instances.id,
            module.eks_master_instances.eks_id,
          )
          values = ["owned"]
        },
        {
          test     = "StringEquals"
          variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
          values   = ["true"]
        },
      ]
      principals = [
        {
          type        = ""
          identifiers = []
        }
      ]
    },
  ]

  # eks_worker_autoscaling_iam_role_policy_description = format(
  #   "%s %s %s %s",
  #   lower(var.eks_cluster_resource_prefix),
  #   lower(var.environment_name),
  #   lower(var.eks_worker_tier_name),
  #   "autoscaling node IAM role policy."
  # )
  #
  # eks_worker_iam_role_policy_description = format(
  #   "%s %s %s %s",
  #   lower(var.eks_cluster_resource_prefix),
  #   lower(var.environment_name),
  #   lower(var.eks_worker_tier_name),
  #   "node IAM role policy."
  # )
  #
  # eks_worker_iam_role_policy_attachments = list(
  #   # module.eks_worker_iam_role_policy.arn,
  #   module.eks_worker_autoscaling_iam_role_policy.arn,
  #   data.aws_iam_policy.amazon_eks_worker_node_policy.arn,
  #   data.aws_iam_policy.amazon_ec2_container_registry_ro_policy.arn,
  #   data.aws_iam_policy.amazon_eks_cni_policy.arn,
  # )
  #
  # eks_worker_kms_key_policy_document_statements = [
  #   {
  #     sid       = "EnableIAMUserPermissions"
  #     effect    = "Allow"
  #     actions   = ["kms:*"]
  #     resources = ["*"]
  #     condition = [
  #       {
  #         test     = ""
  #         variable = ""
  #         values   = []
  #       }
  #     ]
  #     principals = [
  #       {
  #         type = "AWS"
  #         identifiers = [
  #           format(
  #             "%s%s%s",
  #             "arn:aws:iam::",
  #             data.aws_caller_identity.current.account_id,
  #             ":root"
  #           )
  #         ]
  #       }
  #     ]
  #   },
  #   {
  #     sid    = "AllowAccessForKeyAdministrators"
  #     effect = "Allow"
  #     actions = [
  #       "kms:Create*",
  #       "kms:Describe*",
  #       "kms:Enable*",
  #       "kms:List*",
  #       "kms:Put*",
  #       "kms:Update*",
  #       "kms:Revoke*",
  #       "kms:Disable*",
  #       "kms:Get*",
  #       "kms:Delete*",
  #       "kms:TagResource",
  #       "kms:UntagResource",
  #       "kms:ScheduleKeyDeletion",
  #       "kms:CancelKeyDeletion"
  #     ]
  #     resources = ["*"]
  #     condition = [
  #       {
  #         test     = ""
  #         variable = ""
  #         values   = []
  #       }
  #     ]
  #     principals = [
  #       {
  #         type = "AWS"
  #         identifiers = [
  #           format(
  #             "%s%s%s",
  #             "arn:aws:iam::",
  #             data.aws_caller_identity.current.account_id,
  #             ":role/Administrator"
  #           )
  #         ]
  #       }
  #     ]
  #   },
  #   {
  #     sid    = "AllowUseOfTheKey"
  #     effect = "Allow"
  #     actions = [
  #       "kms:Encrypt",
  #       "kms:Decrypt",
  #       "kms:ReEncrypt*",
  #       "kms:GenerateDataKey*",
  #       "kms:DescribeKey"
  #     ]
  #     resources = ["*"]
  #     condition = [
  #       {
  #         test     = ""
  #         variable = ""
  #         values   = []
  #       }
  #     ]
  #     principals = [
  #       {
  #         type = "AWS"
  #         identifiers = [
  #           format(
  #             "%s%s%s%s",
  #             "arn:aws:iam::",
  #             data.aws_caller_identity.current.account_id,
  #             ":role/",
  #             module.eks_worker_iam_role.name
  #           )
  #         ]
  #       }
  #     ]
  #   },
  #   {
  #     sid    = "AllowAttachmentOfPersistentResources"
  #     effect = "Allow"
  #     actions = [
  #       "kms:CreateGrant",
  #       "kms:ListGrants",
  #       "kms:RevokeGrant"
  #     ]
  #     resources = ["*"]
  #     condition = [
  #       {
  #         test     = "Bool"
  #         variable = "kms:GrantIsForAWSResource"
  #         values   = ["true"]
  #       }
  #     ]
  #     principals = [
  #       {
  #         type = "AWS"
  #         identifiers = [
  #           format(
  #             "%s%s%s%s",
  #             "arn:aws:iam::",
  #             data.aws_caller_identity.current.account_id,
  #             ":role/",
  #             module.eks_worker_iam_role.name
  #           )
  #         ]
  #       }
  #     ]
  #   }
  # ]
  #
  # eks_worker_kms_key_description = format(
  #   "%s %s %s %s",
  #   lower(var.eks_cluster_resource_prefix),
  #   lower(var.environment_name),
  #   lower(var.eks_worker_tier_name),
  #   "node kms key."
  # )
  #
  # eks_worker_kms_key_usage = "ENCRYPT_DECRYPT"
  #
  # eks_worker_security_group_ingress_rules = concat(
  #   [
  #     {
  #       from_port       = 0
  #       to_port         = 0
  #       protocol        = "-1"
  #       cidr_blocks     = []
  #       security_groups = []
  #       self            = true
  #       description     = "Allow worker nodes to communicated with themselves."
  #     },
  #     {
  #       from_port       = 1025
  #       to_port         = 65535
  #       protocol        = "tcp"
  #       cidr_blocks     = []
  #       security_groups = [module.eks_master_security_group.id]
  #       self            = false
  #       description     = "Allow Kubelets to receive communication from the cluster master nodes."
  #     },
  #     {
  #       from_port       = 443
  #       to_port         = 443
  #       protocol        = "tcp"
  #       cidr_blocks     = []
  #       security_groups = [module.eks_master_security_group.id]
  #       self            = false
  #       description     = "Allow Kubelets to receive communication from the cluster master nodes."
  #     }
  #   ],
  #   var.eks_worker_security_group_custom_ingress_rules,
  #   local.eks_common_security_group_ingress_rules,
  # )
  #
  # eks_worker_security_group_egress_rules = concat(
  #   [
  #     {
  #       from_port       = 0
  #       to_port         = 0
  #       protocol        = "-1"
  #       cidr_blocks     = ["0.0.0.0/0"]
  #       security_groups = []
  #       self            = false
  #       description     = "Allow nodes all egress to the Internet."
  #     },
  #   ],
  #   var.eks_worker_security_group_custom_egress_rules,
  # )

  instance_type_standard = [
    "t3.medium",
  ]
  instance_type_ebs_optimized = []

  # instance_type_standard = [
  #   "t2.medium",
  #   "t2.large",
  #   "t2.xlarge",
  #   "t2.2xlarge",
  #   "t3.medium",
  #   "t3.large",
  #   "t3.xlarge",
  #   "t3.2xlarge",
  #   "t3a.medium",
  #   "t3a.large",
  #   "t3a.xlarge",
  #   "t3a.2xlarge",
  # ]

  # instance_type_ebs_optimized = [
  #   "m4.large",
  #   "m4.xlarge",
  #   "m4.2xlarge",
  #   "m4.4xlarge",
  #   "m4.10xlarge",
  #   "m4.16xlarge",
  #   "m5.large",
  #   "m5.xlarge",
  #   "m5.2xlarge",
  #   "m5.4xlarge",
  #   "m5.8xlarge",
  #   "m5.12xlarge",
  #   "m5.16xlarge",
  #   "m5.24xlarge",
  #   "m5a.large",
  #   "m5a.xlarge",
  #   "m5a.2xlarge",
  #   "m5a.4xlarge",
  #   "m5a.8xlarge",
  #   "m5a.12xlarge",
  #   "m5a.16xlarge",
  #   "m5a.24xlarge",
  #   "m5n.large",
  #   "m5n.xlarge",
  #   "m5n.2xlarge",
  #   "m5n.4xlarge",
  #   "m5n.8xlarge",
  #   "m5n.12xlarge",
  #   "m5n.16xlarge",
  #   "m5n.24xlarge",
  #   "m6g.medium",
  # "m6g.large",
  # "m6g.xlarge",
  # "m6g.2xlarge",
  # "m6g.4xlarge",
  # "m6g.8xlarge",
  # "m6g.12xlarge",
  # "m6g.16xlarge",
  #   "c4.large",
  #   "c4.xlarge",
  #   "c4.2xlarge",
  #   "c4.4xlarge",
  #   "c4.8xlarge",
  #   "c5.large",
  #   "c5.xlarge",
  #   "c5.2xlarge",
  #   "c5.4xlarge",
  #   "c5.9xlarge",
  #   "c5.12xlarge",
  #   "c5.18xlarge",
  #   "c5.24xlarge",
  #   "c5n.large",
  #   "c5n.xlarge",
  #   "c5n.2xlarge",
  #   "c5n.4xlarge",
  #   "c5n.9xlarge",
  #   "c5n.18xlarge",
  #   "r4.large",
  #   "r4.xlarge",
  #   "r4.2xlarge",
  #   "r4.4xlarge",
  #   "r4.8xlarge",
  #   "r4.16xlarge",
  #   "r5.large",
  #   "r5.xlarge",
  #   "r5.2xlarge",
  #   "r5.4xlarge",
  #   "r5.8xlarge",
  #   "r5.12xlarge",
  #   "r5.16xlarge",
  #   "r5.24xlarge",
  #   "r5.metal",
  #   "r5a.large",
  #   "r5a.xlarge",
  #   "r5a.2xlarge",
  #   "r5a.4xlarge",
  #   "r5a.8xlarge",
  #   "r5a.12xlarge",
  #   "r5a.16xlarge",
  #   "r5a.24xlarge",
  #   "r5n.large",
  #   "r5n.xlarge",
  #   "r5n.2xlarge",
  #   "r5n.4xlarge",
  #   "r5n.8xlarge",
  #   "r5n.12xlarge",
  #   "r5n.16xlarge",
  #   "r5n.24xlarge",
  # ]

  placement_group_cluster_strategy_supported_types = [
    "a1.2xlarge",
    "a1.4xlarge",
    "a1.large",
    "a1.medium",
    "a1.metal",
    "a1.xlarge",
    "c3.2xlarge",
    "c3.4xlarge",
    "c3.8xlarge",
    "c3.large",
    "c3.xlarge",
    "c4.2xlarge",
    "c4.4xlarge",
    "c4.8xlarge",
    "c4.large",
    "c4.xlarge",
    "c5.12xlarge",
    "c5.18xlarge",
    "c5.24xlarge",
    "c5.2xlarge",
    "c5.4xlarge",
    "c5.8xlarge",
    "c5.large",
    "c5.metal",
    "c5.xlarge",
    "c5d.12xlarge",
    "c5d.18xlarge",
    "c5d.24xlarge",
    "c5d.2xlarge",
    "c5d.4xlarge",
    "c5d.9xlarge",
    "c5d.large",
    "c5d.metal",
    "c5d.xlarge",
    "c5n.18xlarge",
    "c5n.2xlarge",
    "c5n.4xlarge",
    "c5n.9xlarge",
    "c5n.large",
    "c5n.metal",
    "c5n.xlarge",
    "cc2.8xlarge",
    "cr1.8xlarge",
    "d2.2xlarge",
    "d2.4xlarge",
    "d2.8xlarge",
    "d2.xlarge",
    "f1.16xlarge",
    "f1.2xlarge",
    "f1.4xlarge",
    "g3.16xlarge",
    "g3.4xlarge",
    "g3.8xlarge",
    "g3s.xlarge",
    "g4dn.12xlarge",
    "g4dn.16xlarge",
    "g4dn.2xlarge",
    "g4dn.4xlarge",
    "g4dn.8xlarge",
    "g4dn.xlarge",
    "h1.16xlarge",
    "h1.2xlarge",
    "h1.4xlarge",
    "h1.8xlarge",
    "hs1.8xlarge",
    "i3.16xlarge",
    "i3.2xlarge",
    "i3.4xlarge",
    "i3.8xlarge",
    "i3.large",
    "i3.metal",
    "i3.xlarge",
    "i3en.12xlarge",
    "i3en.24xlarge",
    "i3en.2xlarge",
    "i3en.3xlarge",
    "i3en.6xlarge",
    "i3en.large",
    "i3en.metal",
    "i3en.xlarge",
    "inf1.24xlarge",
    "inf1.2xlarge",
    "inf1.6xlarge",
    "inf1.xlarge",
    "m4.10xlarge",
    "m4.16xlarge",
    "m4.2xlarge",
    "m4.4xlarge",
    "m4.large",
    "m4.xlarge",
    "m5.12xlarge",
    "m5.16xlarge",
    "m5.24xlarge",
    "m5.2xlarge",
    "m5.4xlarge",
    "m5.8xlarge",
    "m5.large",
    "m5.metal",
    "m5.xlarge",
    "m5a.12xlarge",
    "m5a.16xlarge",
    "m5a.24xlarge",
    "m5a.2xlarge",
    "m5a.4xlarge",
    "m5a.8xlarge",
    "m5a.large",
    "m5a.xlarge",
    "m5ad.12xlarge",
    "m5ad.24xlarge",
    "m5ad.2xlarge",
    "m5ad.4xlarge",
    "m5ad.large",
    "m5ad.xlarge",
    "m5d.12xlarge",
    "m5d.16xlarge",
    "m5d.24xlarge",
    "m5d.2xlarge",
    "m5d.4xlarge",
    "m5d.8xlarge",
    "m5d.large",
    "m5d.metal",
    "m5d.xlarge",
    "m5dn.12xlarge",
    "m5dn.16xlarge",
    "m5dn.24xlarge",
    "m5dn.2xlarge",
    "m5dn.4xlarge",
    "m5dn.8xlarge",
    "m5dn.large",
    "m5dn.xlarge",
    "m5n.12xlarge",
    "m5n.16xlarge",
    "m5n.24xlarge",
    "m5n.2xlarge",
    "m5n.4xlarge",
    "m5n.8xlarge",
    "m5n.large",
    "m5n.xlarge",
    "p2.16xlarge",
    "p2.8xlarge",
    "p2.xlarge",
    "p3.16xlarge",
    "p3.2xlarge",
    "p3.8xlarge",
    "p3dn.24xlarge",
    "r4.16xlarge",
    "r4.2xlarge",
    "r4.4xlarge",
    "r4.8xlarge",
    "r4.large",
    "r4.xlarge",
    "r5.12xlarge",
    "r5.16xlarge",
    "r5.24xlarge",
    "r5.2xlarge",
    "r5.4xlarge",
    "r5.8xlarge",
    "r5.large",
    "r5.metal",
    "r5.xlarge",
    "r5a.12xlarge",
    "r5a.16xlarge",
    "r5a.24.xlarge",
    "r5a.2xlarge",
    "r5a.4xlarge",
    "r5a.8xlarge",
    "r5a.large",
    "r5a.xlarge",
    "r5ad.12xlarge",
    "r5ad.24.xlarge	",
    "r5ad.2xlarge",
    "r5ad.4xlarge",
    "r5ad.large",
    "r5ad.xlarge",
    "r5d.12xlarge",
    "r5d.16xlarge",
    "r5d.24xlarge",
    "r5d.2xlarge",
    "r5d.4xlarge",
    "r5d.8xlarge",
    "r5d.large",
    "r5d.metal",
    "r5d.xlarge",
    "r5dn.12xlarge",
    "r5dn.16xlarge",
    "r5dn.24xlarge",
    "r5dn.2xlarge",
    "r5dn.4xlarge",
    "r5dn.8xlarge",
    "r5dn.large",
    "r5dn.xlarge",
    "r5n.12xlarge",
    "r5n.16xlarge",
    "r5n.24xlarge",
    "r5n.2xlarge",
    "r5n.4xlarge",
    "r5n.8xlarge",
    "r5n.large",
    "r5n.xlarge",
    "x1.16xlarge",
    "x1.32xlarge",
    "x1e.16xlarge",
    "x1e.2xlarge",
    "x1e.32xlarge",
    "x1e.4xlarge",
    "x1e.8xlarge",
    "x1e.xlarge",
    "z1d.12xlarge",
    "z1d.2xlarge",
    "z1d.3xlarge",
    "z1d.6xlarge",
    "z1d.large",
    "z1d.metal",
    "z1d.xlarge"
  ]

  #   eks_worker_instance_types = var.eks_worker_ebs_optimized ? local.instance_type_ebs_optimized : var.eks_worker_placement_group_strategy == "cluster" ? setintersection(concat(local.instance_type_standard, local.instance_type_ebs_optimized), local.placement_group_cluster_strategy_supported_types) : concat(local.instance_type_standard, local.instance_type_ebs_optimized)
  #
  #   eks_worker_user_data = templatefile(
  #     "${path.module}/templates/eks_worker_instances_userdata.sh.tpl",
  #     {
  #       eks_cluster_region               = data.aws_region.current.name
  #       eks_cluster_name                 = module.eks_master_instances.id
  #       eks_cluster_auth_base64          = module.eks_master_instances.certificate_authority_data
  #       eks_cluster_endpoint             = module.eks_master_instances.endpoint
  #       eks_cluster_bootstrap_extra_args = var.eks_cluster_bootstrap_extra_args
  #       eks_cluster_kubelet_extra_args   = var.eks_cluster_kubelet_extra_args
  #     }
  #   )
  #
  #   eks_worker_health_check_grace_period = 120
  #
  #   eks_worker_health_check_type = length(var.eks_worker_target_group_arns) == 0 ? "EC2" : "ELB"
  #
  #   eks_worker_image_id = var.eks_worker_image_id != "" ? var.eks_worker_image_id : data.aws_ami.eks_worker_ami.image_id
  #
  #   eks_worker_ec2_instance_tags = merge(
  #     var.ec2_instance_tags,
  #     {
  #       "k8s.io/cluster-autoscaler/${module.eks_master_instances.id}" = "owned"
  #       "k8s.io/cluster-autoscaler/enabled"                           = "true"
  #       "kubernetes.io/cluster/${module.eks_master_instances.id}"     = "owned"
  #       "eks:cluster-name"                                            = "${module.eks_master_instances.id}"
  #       "k8s.io/cluster-autoscaler/node-template/label/lifecycle"     = "Ec2Spot"
  #       "k8s.io/cluster-autoscaler/node-template/label/intent"        = "apps"
  #       "k8s.io/cluster-autoscaler/node-template/taint/spotInstance"  = "true:PreferNoSchedule"
  #     }
  #   )
  #
  #   k8s_default_namespace_name           = "kube-system"
  #   k8s_default_aws_auth_config_map_name = "aws-auth"
  #
  #   eks_worker_k8s_config_map_data_payload = templatefile(
  #     "${path.module}/templates/eks_worker_k8s_config_map.yml.tpl",
  #     {
  #       role_arn = module.eks_worker_iam_role.arn
  #     }
  #   )
}
