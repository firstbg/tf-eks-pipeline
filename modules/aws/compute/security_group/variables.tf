variable "security_group_resource_prefix" {
  type        = string
  description = "The prefix name convention for Security Group object."
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment."
}

variable "security_group_tier_name" {
  type        = string
  description = "The tier name convention for Security Group object."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to create the Security Group."
}

variable "security_group_ingress_rules" {
  type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
  description = "List of maps of ingress rules to set on the Security Group"
}

variable "security_group_egress_rules" {
  type        = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), security_groups = list(string), self = bool, description = string }))
  description = "List of maps of egress rules to set on the Security Group"
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "security_group_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to Security Group."
}
