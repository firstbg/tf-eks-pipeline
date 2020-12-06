variable "eks_cluster_resource_prefix" {
  type        = string
  description = "The prefix name for EKS Cluster"
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment"
}

variable "eks_cluster_tier_name" {
  type        = string
  description = "The tier name convention for EKS Cluster object"
}

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "eks_cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "eks_cluster_enabled_log_types" {
  type        = list(string)
  description = "A list of the desired EKS control plane logging to enable."
}

variable "eks_cluster_version" {
  type        = string
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "eks_cluster_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to EKS Cluster."
}
