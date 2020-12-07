variable "common_region" {
  type        = string
  description = "The Region where to create resources"
}

variable "account_id" {
  type        = string
  description = "The Organizations Account ID for the account."
}

variable "terraform_assume_role_name" {
  type        = string
  description = "The role name to be assumed."
}

variable "iam_policy_resource_prefix" {
  type        = string
  description = "The prefix name convention for IAM Policy object."
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment."
}

variable "eks_master_tier_name" {
  type        = string
  description = "The tier name convention for EKS Cluster object."
}

variable "eks_master_iam_role_policy_path" {
  type        = string
  description = "Path in which to create the policy for EKS master nodes."
}

variable "iam_role_resource_prefix" {
  type        = string
  description = "The prefix name convention for IAM Role object."
}

variable "eks_master_iam_role_path" {
  type        = string
  description = "The path of the EKS master nodes IAM role."
}

variable "eks_master_iam_role_max_session_duration" {
  type        = number
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "eks_master_iam_role_permissions_boundary" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the policy that is used to set the permissions boundary for the role."
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "eks_master_iam_role_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to EKS master nodes IAM Role."
}

variable "eks_master_kms_key_deletion_window_in_days" {
  type        = number
  description = "Duration in days after which the key for EKS master nodes is deleted after destruction of the resource, must be between 7 and 30 days."
}

variable "kms_key_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to KMS Key."
}

variable "kms_key_resource_prefix" {
  type        = string
  description = "The prefix name convention for KMS Key object."
}

variable "security_group_resource_prefix" {
  type        = string
  description = "The prefix name convention for Security Group object."
}

variable "vpc_resource_prefix" {
  type        = string
  description = "The prefix name convention for Network VPC object."
}

variable "security_group_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to Security Group."
}

variable "eks_master_security_group_custom_ingress_rules" {
  type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
  description = "List of maps of ingress rules to set on the EKS master nodes Security Group. Add any expected access via kubectl."
}

variable "eks_master_security_group_custom_egress_rules" {
  type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
  description = "List of maps of egress rules to set on the EKS worker nodes Security Group."
}

variable "eks_cluster_resource_prefix" {
  type        = string
  description = "The prefix name convention for EKS Cluster object."
}

variable "eks_node_group_resource_prefix" {
  type        = string
  description = "The prefix name convention for EKS Node Group object."
}

variable "subnet_resource_prefix" {
  type        = string
  description = "The prefix name convention for Network Private Subnets object."
}

variable "private_subnet_tier_name" {
  type        = string
  description = "The tier name convention for Private Subnet object."
}

variable "eks_cluster_enabled_log_types" {
  type        = list(string)
  description = "A list of the desired EKS control plane logging to enable."
}

variable "eks_cluster_version" {
  type        = string
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
}

variable "eks_cluster_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to EKS Cluster."
}
#
# variable "eks_worker_tier_name" {
#   type        = string
#   description = "The tier name convention for EKS Worker node object."
# }
#
# variable "eks_worker_iam_role_policy_path" {
#   type        = string
#   description = "Path in which to create the policy for EKS worker nodes."
# }
#
# variable "eks_worker_iam_role_path" {
#   type        = string
#   description = "Path in which to create the policy for EKS worker nodes."
# }
#
# variable "eks_worker_iam_role_max_session_duration" {
#   type        = number
#   description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
# }
#
# variable "eks_worker_iam_role_permissions_boundary" {
#   type        = string
#   description = "The Amazon Resource Name (ARN) of the policy that is used to set the permissions boundary for the role."
# }
#
# variable "eks_worker_iam_role_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to EKS worker nodes IAM Role."
# }
#
# variable "eks_worker_kms_key_deletion_window_in_days" {
#   type        = number
#   description = "Duration in days after which the key for EKS worker nodes is deleted after destruction of the resource, must be between 7 and 30 days."
# }
#
# variable "eks_worker_security_group_custom_ingress_rules" {
#   type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
#   description = "List of maps of ingress rules to set on the EKS worker nodes Security Group. Add any expected privileged service port input."
# }
#
# variable "eks_worker_security_group_custom_egress_rules" {
#   type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
#   description = "List of maps of egress rules to set on the EKS worker nodes Security Group."
# }
#
# variable "placement_group_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for Placement Group object."
# }
#
# variable "instance_profile_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for Instance Profile object."
# }
#
# variable "launch_template_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for Launch Template object."
# }
#
# variable "eks_worker_placement_group_strategy" {
#   type        = string
#   description = "The placement strategy for EKS worker nodes. Allowed values are cluster, partition, spread."
# }
#
# variable "eks_worker_block_device_mappings" {
#   type        = list(object({ device_name = string, no_device = bool, iops = number, kms_key_id = string, volume_size = number, volume_type = string }))
#   description = " A list of nested configuration block to specify volumes to attach to the instance besides the volumes specified by the AMI. Each statement can have the following sub-blocks: device_name = string, no_device = bool, iops = number, kms_key_id = string, volume_size = number, volume_type = string. Remember that for Provisioned IOPS (io1) volumes, you can provision up to 50 IOPS per GiB. For General Purpose (gp2) volumes, baseline performance is 3 IOPS per GiB, with a minimum of 100 IOPS and a maximum of 16000 IOPS. If kms_key_id is not specified AWS Managed KMS key for EBS will be used."
# }
#
# variable "eks_worker_cpu_credits" {
#   type        = string
#   description = "The credit option for CPU usage. Can be `standard` or `unlimited`."
# }
#
# variable "eks_worker_ebs_optimized" {
#   type        = bool
#   description = "A flag to enable/disable launch EBS-optimized EC2 Instances. In case ebs optimized is not available in any of the instance type Terraform will throw an error. It is highly recommended to set this flag to `true` in production."
# }
#
# variable "eks_worker_image_id" {
#   type        = string
#   description = "The AMI from which to launch the instance."
# }
#
# variable "eks_worker_instance_initiated_shutdown_behavior" {
#   type        = string
#   description = "Shutdown behavior for the instance. Can be stop or terminate."
# }
#
# variable "eks_worker_key_name" {
#   type        = string
#   description = "The key name to use for the instance."
# }
#
# variable "eks_worker_detailed_monitoring_enabled" {
#   type        = bool
#   description = "A flag to enable/disabledetailed monitoring on the launched EC2 instance."
# }
#
# variable "ec2_instance_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to EC2 Instance."
# }
#
# variable "ec2_instance_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for EC2 instance object."
# }
#
# variable "launch_template_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to Launch Template."
# }
#
# variable "autoscaling_group_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to Autoscaling Group resource."
# }
#
# variable "autoscaling_group_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for AutoScaling Group object."
# }
#
# variable "eks_worker_max_size" {
#   type        = number
#   description = "The maximum size of the auto scale group."
# }
#
# variable "eks_worker_min_size" {
#   type        = number
#   description = "The minimum size of the auto scale group."
# }
#
# variable "ebs_volume_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for EBS Volume object."
# }
#
# variable "ebs_volume_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to EBS Volume resource."
# }
#
# variable "eks_worker_desired_capacity" {
#   type        = number
#   description = "The number of Amazon EC2 instances that should be running in the group."
# }
#
# variable "eks_cluster_bootstrap_extra_args" {
#   type        = string
#   description = "Extra parameters to add to EKS Workers /etc/eks/bootstrap.sh bootstrap script. Note that if you need to use docker on docker you will need to add `--enable-docker-bridge true` here."
# }
#
# variable "eks_cluster_kubelet_extra_args" {
#   type        = string
#   description = "Extra arguments to add to EKS Workers /etc/eks/bootstrap.sh bootstrap script for option --kubelet-extra-args."
# }
#
# variable "eks_worker_target_group_arns" {
#   type        = list(string)
#   description = "A list of Application LoadBalancer (ALB) target group ARNs to be associated to the autoscaling group."
# }
#
# variable "eks_worker_suspended_processes" {
#   type        = list(string)
#   description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
# }
#
# variable "eks_worker_termination_policies" {
#   type        = list(string)
#   description = "A list of policies names to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default."
# }
#
# variable "eks_worker_enabled_metrics" {
#   type        = list(string)
#   description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances."
# }
#
# variable "eks_worker_wait_for_capacity_timeout" {
#   type        = string
#   description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to `0` causes Terraform to skip all Capacity Waiting behavior. The minimum value for production should be `10m`"
# }
#
# variable "eks_worker_min_elb_capacity" {
#   type        = number
#   description = "Setting this causes Terraform to wait for this number of instances from this autoscaling group to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes."
# }
#
# variable "eks_worker_wait_for_elb_capacity" {
#   type        = number
#   description = "Setting this will cause Terraform to wait for exactly this number of healthy instances from this autoscaling group in all attached load balancers on both create and update operations. (Takes precedence over min_elb_capacity behavior.)"
# }
#
# variable "eks_worker_protect_from_scale_in" {
#   type        = bool
#   description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
# }
#
# variable "eks_worker_service_linked_role_name" {
#   type        = string
#   description = "The ARN of the service-linked role that the ASG will use to call other AWS services. AWS default role name is `AWSServiceRoleForAutoScaling`."
# }
#
# variable "eks_worker_on_demand_base_capacity" {
#   type        = string
#   description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances."
# }
#
# variable "eks_worker_on_demand_percentage_above_base_capacity" {
#   type        = number
#   description = "Percentage split between on-demand and Spot instances above the base on-demand capacity."
# }
#
# variable "eks_worker_spot_allocation_strategy" {
#   type        = string
#   description = "How to allocate capacity across the Spot pools. Valid values: lowest-price, capacity-optimized."
# }
#
# variable "eks_worker_spot_max_price" {
#   type        = string
#   description = "Maximum price per unit hour that the user is willing to pay for the Spot instances. An empty string means the on-demand price."
# }
#
# variable "autoscaling_lifecycle_hook_resource_prefix" {
#   type        = string
#   description = "The prefix name convention for Autoscaling Lifecycle Hook object."
# }
#
# variable "eks_worker_default_result" {
#   type        = string
#   description = "Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON."
# }
#
# variable "eks_worker_lifecycle_transition" {
#   type        = string
#   description = "The instance state to which you want to attach the lifecycle hook. The valid values are: `autoscaling:EC2_INSTANCE_LAUNCHING` and `autoscaling:EC2_INSTANCE_TERMINATING`."
# }
#
# variable "eks_worker_notification_metadata" {
#   type        = string
#   description = "Contains additional information that you want to include any time Auto Scaling sends a message to the notification target."
# }
#
# variable "eks_worker_heartbeat_timeout" {
#   type        = number
#   description = "Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter."
# }
#
# variable "eks_worker_notification_target_arn" {
#   type        = string
#   description = "The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic."
# }
#
# variable "eks_worker_role_arn" {
#   type        = string
#   description = "The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target."
# }
#
# variable "eks_node_group_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to EKS Node Group resource."
# }
