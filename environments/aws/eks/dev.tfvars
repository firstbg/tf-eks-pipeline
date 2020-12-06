
# Organization
organizations_shared_account_id = "235297331187"
account_id                      = "235297331187"
organizations_dev_account_id    = ""
organizations_stg_account_id    = ""
organizations_prod_account_id   = ""
organizations_ou_myteam_id      = ""

# Global
common_region       = "eu-central-1"
vpc_tags            = {}
vpc_resource_prefix = "vpc"
common_tags = {
  Terraform = "true",
  Team      = "myteam"
}
dhcp_options_tags                              = {}
dhcp_options_resource_prefix                   = "dpo"
subnet_resource_prefix                         = "net"
public_subnet_tags                             = {}
public_subnet_tier_name                        = "public"
private_subnet_tags                            = {}
private_subnet_tier_name                       = "private"
data_subnet_tags                               = {}
data_subnet_tier_name                          = "data"
db_subnet_group_resource_prefix                = "sng"
db_subnet_group_tags                           = {}
default_network_acl_tags                       = {}
network_acl_resource_prefix                    = "nacl"
default_network_acl_tier_name                  = "default"
public_network_acl_tags                        = {}
private_network_acl_tags                       = {}
data_network_acl_tags                          = {}
internet_gateway_tags                          = {}
internet_gateway_resource_prefix               = "igw"
eip_tags                                       = {}
nat_eip_resource_prefix                        = "eip"
nat_eip_tier_name                              = "public"
nat_gateway_tags                               = {}
nat_gateway_resource_prefix                    = "ngw"
route_table_tags                               = {}
route_table_resource_prefix                    = "rtb"
transit_gateway_tags                           = {}
transit_gateway_resource_prefix                = "tgw"
transit_gateway_vpc_attachment_tags            = {}
transit_gateway_vpc_attachment_resource_prefix = "tga"
transit_gateway_route_table_tags               = {}
transit_gateway_route_table_resource_prefix    = "tgr"
ram_resource_share_tags                        = {}
ram_resource_share_resource_prefix             = "ram"


eks_cluster_resource_prefix                = "eks"
eks_cluster_tier_name                      = "master"
terraform_assume_role_name                 = ""
iam_policy_resource_prefix                 = "eksiampolicy"
environment_name                           = "shared"
eks_master_tier_name                       = ""
eks_master_iam_role_policy_path            = ""
iam_role_resource_prefix                   = "eksiamrole"
eks_master_iam_role_path                   = "/"
eks_master_iam_role_max_session_duration   = 7200 # seconds
eks_master_iam_role_permissions_boundary   = ""
eks_master_iam_role_tags                   = {}
eks_master_kms_key_deletion_window_in_days = 7
kms_key_tags                               = {}
kms_key_resource_prefix                    = "ekskms"
security_group_resource_prefix             = "ekssg"
security_group_tags                        = {}
# eks_master_security_group_custom_ingress_rules = [
#   {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#     security_groups = [""]
#     self            = true
#     description     = "EKS custom ingress rule"
#   },
# ]

eks_master_security_group_custom_ingress_rules = []
# eks_master_security_group_custom_egress_rules = [
#   {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#     security_groups = [""]
#     self            = true
#     description     = "EKS custom egress rule"
#   },
# ]
eks_master_security_group_custom_egress_rules = []

eks_node_group_resource_prefix = "eksnode"
eks_cluster_enabled_log_types  = []
eks_cluster_version            = "1.18" #1.18, 1.17, 1.16, 1.15, 1.14
eks_cluster_tags               = {}
# eks_worker_tier_name = ""
# eks_worker_iam_role_policy_path = ""
# eks_worker_iam_role_path = ""
# eks_worker_iam_role_max_session_duration =
# eks_worker_iam_role_permissions_boundary =
# eks_worker_iam_role_tags
# eks_worker_kms_key_deletion_window_in_days
# eks_worker_security_group_custom_ingress_rules
# eks_worker_security_group_custom_egress_rules
# placement_group_resource_prefix
# instance_profile_resource_prefix
# launch_template_resource_prefix
# eks_worker_placement_group_strategy
# eks_worker_block_device_mappings
# eks_worker_cpu_credits
# eks_worker_ebs_optimized
# eks_worker_image_id
# eks_worker_instance_initiated_shutdown_behavior
# eks_worker_key_name
# eks_worker_detailed_monitoring_enabled
# ec2_instance_tags
# ec2_instance_resource_prefix
# launch_template_tags
# autoscaling_group_tags
# autoscaling_group_resource_prefix
# eks_worker_max_size
# eks_worker_min_size
# ebs_volume_resource_prefix
# ebs_volume_tags
# eks_worker_desired_capacity
# eks_cluster_bootstrap_extra_args
# eks_cluster_kubelet_extra_args
# eks_worker_target_group_arns
# eks_worker_suspended_processes
# eks_worker_termination_policies
# eks_worker_enabled_metrics
# eks_worker_wait_for_capacity_timeout
# eks_worker_min_elb_capacity
# eks_worker_wait_for_elb_capacity
# eks_worker_protect_from_scale_in
# eks_worker_service_linked_role_name
# eks_worker_on_demand_base_capacity
# eks_worker_on_demand_percentage_above_base_capacity
# eks_worker_spot_allocation_strategy
# eks_worker_spot_max_price
# autoscaling_lifecycle_hook_resource_prefix
# eks_worker_default_result
# eks_worker_lifecycle_transition
# eks_worker_notification_metadata
# eks_worker_heartbeat_timeout
# eks_worker_notification_target_arn
# eks_worker_role_arn
# eks_node_group_tags
