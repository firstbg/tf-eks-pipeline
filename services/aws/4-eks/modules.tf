module "eks_master_iam_role_assume_role_policy_document" {
  source = "../../../modules/aws/identity/iam/policy_document"

  statements = local.eks_master_iam_assume_role_policy_document_statements
}

module "eks_master_iam_role" {
  source = "../../../modules/aws/identity/iam/role"

  iam_role_resource_prefix         = var.iam_role_resource_prefix
  environment_name                 = var.environment_name
  iam_role_tier_name               = var.eks_master_tier_name
  assume_role_policy_document_json = module.eks_master_iam_role_assume_role_policy_document.json
  path                             = var.eks_master_iam_role_path
  max_session_duration             = var.eks_master_iam_role_max_session_duration
  permissions_boundary             = var.eks_master_iam_role_permissions_boundary
  common_tags                      = var.common_tags
  iam_role_tags                    = var.eks_master_iam_role_tags
  aws_iam_role_policy_attachments  = local.eks_master_iam_role_policy_attachments
}

module "eks_master_kms_key_policy_document" {
  source = "../../../modules/aws/identity/iam/policy_document"

  statements = local.eks_master_kms_key_policy_document_statements
}

module "eks_master_kms_key" {
  source = "../../../modules/aws/identity/kms"

  description             = local.eks_master_kms_key_description
  key_usage               = local.eks_master_kms_key_usage
  policy_document         = module.eks_master_kms_key_policy_document.json
  deletion_window_in_days = var.eks_master_kms_key_deletion_window_in_days
  common_tags             = var.common_tags
  kms_key_tags            = var.kms_key_tags
  kms_key_resource_prefix = var.kms_key_resource_prefix
  environment_name        = var.environment_name
  kms_key_tier_name       = var.eks_master_tier_name
}

module "eks_master_security_group" {
  source = "../../../modules/aws/compute/security_group"

  security_group_resource_prefix = var.security_group_resource_prefix
  environment_name               = var.environment_name
  security_group_tier_name       = var.eks_master_tier_name
  vpc_id                         = data.aws_vpc.current.id
  security_group_ingress_rules   = local.eks_master_security_group_ingress_rules
  security_group_egress_rules    = local.eks_master_security_group_egress_rules
  common_tags                    = var.common_tags
  security_group_tags            = var.security_group_tags
}

module "eks_master_instances" {
  source = "../../../modules/aws/compute/eks/cluster"

  eks_cluster_resource_prefix   = var.eks_cluster_resource_prefix
  environment_name              = var.environment_name
  eks_cluster_tier_name         = var.eks_master_tier_name
  role_arn                      = module.eks_master_iam_role.arn
  security_group_ids            = list(module.eks_master_security_group.id)
  eks_cluster_subnet_ids        = data.aws_subnet_ids.private.ids
  eks_cluster_enabled_log_types = var.eks_cluster_enabled_log_types
  eks_cluster_version           = var.eks_cluster_version
  common_tags                   = var.common_tags
  eks_cluster_tags              = var.eks_cluster_tags
}

module "eks_worker_iam_assume_role_policy_document" {
  source = "../../../modules/aws/identity/iam/policy_document"

  statements = local.eks_worker_iam_assume_role_policy_document_statements
}

module "eks_worker_autoscaling_iam_role_policy_document" {
  source = "../../../modules/aws/identity/iam/policy_document"

  statements = local.eks_worker_autoscaling_iam_role_policy_document_statements
}

# module "eks_worker_autoscaling_iam_role_policy" {
#   source = "../../../modules/aws/identity/iam/policy"
#
#   iam_policy_resource_prefix = var.iam_policy_resource_prefix
#   environment_name           = var.environment_name
#   iam_policy_tier_name       = var.eks_worker_tier_name
#   description                = local.eks_worker_autoscaling_iam_role_policy_description
#   path                       = var.eks_worker_iam_role_policy_path
#   policy                     = module.eks_worker_autoscaling_iam_role_policy_document.json
# }
#
# module "eks_worker_iam_role" {
#   source = "../../../modules/aws/identity/iam/role"
#
#   iam_role_resource_prefix         = var.iam_role_resource_prefix
#   environment_name                 = var.environment_name
#   iam_role_tier_name               = var.eks_worker_tier_name
#   assume_role_policy_document_json = module.eks_worker_iam_assume_role_policy_document.json
#   path                             = var.eks_worker_iam_role_path
#   max_session_duration             = var.eks_worker_iam_role_max_session_duration
#   permissions_boundary             = var.eks_worker_iam_role_permissions_boundary
#   common_tags                      = var.common_tags
#   iam_role_tags                    = var.eks_worker_iam_role_tags
#   aws_iam_role_policy_attachments  = local.eks_worker_iam_role_policy_attachments
# }
#
# module "eks_worker_kms_key_policy_document" {
#   source = "../../../modules/aws/identity/iam/policy_document"
#
#   statements = local.eks_worker_kms_key_policy_document_statements
# }
#
# module "eks_worker_kms_key" {
#   source = "../../../modules/aws/identity/kms"
#
#   description             = local.eks_worker_kms_key_description
#   key_usage               = local.eks_worker_kms_key_usage
#   policy_document         = module.eks_worker_kms_key_policy_document.json
#   deletion_window_in_days = var.eks_worker_kms_key_deletion_window_in_days
#   common_tags             = var.common_tags
#   kms_key_tags            = var.kms_key_tags
#   kms_key_resource_prefix = var.kms_key_resource_prefix
#   environment_name        = var.environment_name
#   kms_key_tier_name       = var.eks_worker_tier_name
# }
#
# module "eks_worker_security_group" {
#   source = "../../../modules/aws/compute/security_group"
#
#   security_group_resource_prefix = var.security_group_resource_prefix
#   environment_name               = var.environment_name
#   security_group_tier_name       = var.eks_worker_tier_name
#   vpc_id                         = data.aws_vpc.current.id
#   security_group_ingress_rules   = local.eks_worker_security_group_ingress_rules
#   security_group_egress_rules    = local.eks_worker_security_group_egress_rules
#   common_tags                    = var.common_tags
#   security_group_tags            = var.security_group_tags
# }

# module "eks_worker_autoscaling" {
#   source = "../../../modules/aws/compute/ec2_auto_scaling"
#
#   placement_group_resource_prefix            = var.placement_group_resource_prefix
#   environment_name                           = var.environment_name
#   autoscaling_group_tier_name                = var.eks_worker_tier_name
#   placement_group_strategy                   = var.eks_worker_placement_group_strategy
#   instance_profile_resource_prefix           = var.instance_profile_resource_prefix
#   instance_profile_role_id                   = module.eks_worker_iam_role.id
#   instance_types                             = local.eks_worker_instance_types
#   launch_template_resource_prefix            = var.launch_template_resource_prefix
#   block_device_mappings                      = var.eks_worker_block_device_mappings
#   cpu_credits                                = var.eks_worker_cpu_credits
#   ebs_optimized                              = var.eks_worker_ebs_optimized
#   image_id                                   = local.eks_worker_image_id
#   instance_initiated_shutdown_behavior       = var.eks_worker_instance_initiated_shutdown_behavior
#   key_name                                   = var.eks_worker_key_name
#   detailed_monitoring_enabled                = var.eks_worker_detailed_monitoring_enabled
#   vpc_security_group_ids                     = list(module.eks_worker_security_group.id, module.eks_master_security_group.id)
#   user_data                                  = local.eks_worker_user_data
#   common_tags                                = var.common_tags
#   ec2_instance_tags                          = local.eks_worker_ec2_instance_tags
#   ec2_instance_resource_prefix               = var.ec2_instance_resource_prefix
#   launch_template_tags                       = var.launch_template_tags
#   autoscaling_group_tags                     = var.autoscaling_group_tags
#   autoscaling_group_resource_prefix          = var.autoscaling_group_resource_prefix
#   max_size                                   = var.eks_worker_max_size
#   min_size                                   = var.eks_worker_min_size
#   ebs_volume_resource_prefix                 = var.ebs_volume_resource_prefix
#   ebs_volume_tags                            = var.ebs_volume_tags
#   desired_capacity                           = var.eks_worker_desired_capacity
#   health_check_grace_period                  = local.eks_worker_health_check_grace_period
#   health_check_type                          = local.eks_worker_health_check_type
#   vpc_zone_identifier                        = data.aws_subnet_ids.private.ids
#   target_group_arns                          = var.eks_worker_target_group_arns
#   suspended_processes                        = var.eks_worker_suspended_processes
#   termination_policies                       = var.eks_worker_termination_policies
#   enabled_metrics                            = var.eks_worker_enabled_metrics
#   wait_for_capacity_timeout                  = var.eks_worker_wait_for_capacity_timeout
#   min_elb_capacity                           = var.eks_worker_min_elb_capacity
#   wait_for_elb_capacity                      = var.eks_worker_wait_for_elb_capacity
#   protect_from_scale_in                      = var.eks_worker_protect_from_scale_in
#   service_linked_role_arn                    = var.eks_worker_service_linked_role_name != "" ? data.aws_iam_role.eks_worker_service_linked_role.0.arn : ""
#   on_demand_base_capacity                    = var.eks_worker_on_demand_base_capacity
#   on_demand_percentage_above_base_capacity   = var.eks_worker_on_demand_percentage_above_base_capacity
#   spot_allocation_strategy                   = var.eks_worker_spot_allocation_strategy
#   spot_max_price                             = var.eks_worker_spot_max_price
#   autoscaling_lifecycle_hook_resource_prefix = var.autoscaling_lifecycle_hook_resource_prefix
#   default_result                             = var.eks_worker_default_result
#   lifecycle_transition                       = var.eks_worker_lifecycle_transition
#   notification_metadata                      = var.eks_worker_notification_metadata
#   heartbeat_timeout                          = var.eks_worker_heartbeat_timeout
#   notification_target_arn                    = var.eks_worker_notification_target_arn
#   role_arn                                   = var.eks_worker_role_arn
# }
#
# ### When amazon enables Spot instances in managed node groups we can
# ### use it instead of autoscaling groups
# # module "eks_master_node_group" {
# #   source = "../../../modules/aws/compute/eks/node_group"
#
# #   eks_cluster_resource_prefix    = var.eks_cluster_resource_prefix
# #   environment_name               = var.environment_name
# #   eks_cluster_tier_name          = var.eks_master_tier_name
# #   eks_node_group_tier_name       = var.eks_worker_tier_name
# #   eks_node_group_resource_prefix = var.eks_node_group_resource_prefix
# #   node_role_arn                  = module.eks_worker_iam_role.arn
# #   scaling_config_desired_size    = var.eks_worker_desired_capacity
# #   scaling_config_max_size        = var.eks_worker_max_size
# #   scaling_config_min_size        = var.eks_worker_min_size
# #   subnet_ids                     = data.aws_subnet_ids.private.ids
# #   common_tags                    = var.common_tags
# #   eks_node_group_tags            = var.eks_node_group_tags
# # }
#
# module "eks_master_kubectl" {
#   source = "../../../modules/aws/compute/k8s/kubectl"
#
#   eks_cluster_resource_prefix = var.eks_cluster_resource_prefix
#   environment_name            = var.environment_name
#   eks_cluster_tier_name       = var.eks_master_tier_name
#   eks_cluster_arn             = module.eks_master_instances.arn
#   eks_cluster_auth_base64     = module.eks_master_instances.certificate_authority_data
#   eks_cluster_endpoint        = module.eks_master_instances.endpoint
#   eks_config_map_uid          = module.eks_master_node_group_config_map.uid
# }
#
# module "eks_master_node_group_config_map" {
#   source = "../../../modules/aws/compute/k8s/config_map"
#
#   metadata_name      = local.k8s_default_aws_auth_config_map_name
#   metadata_namespace = local.k8s_default_namespace_name
#   data_payload       = local.eks_worker_k8s_config_map_data_payload
#   k8s_endpoint_url   = module.eks_master_instances.endpoint
#   k8s_kubectl_path   = module.eks_master_kubectl.path
# }
#
# module "eks_master_node_group_auto_scaler" {
#   source = "../../../modules/aws/compute/k8s/auto_scaler"
#
#   autoscaling_group_names = list(module.eks_worker_autoscaling.name)
#   k8s_endpoint_url        = module.eks_master_instances.endpoint
#   k8s_kubectl_path        = module.eks_master_kubectl.path
# }
