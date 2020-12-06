variable "iam_role_resource_prefix" {
  type        = string
  description = "The prefix name convention for IAM Role object."
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment."
}

variable "iam_role_tier_name" {
  type        = string
  description = "The tier name convention for IAM Role object."
}

variable "assume_role_policy_document_json" {
  type        = string
  description = "A valid assume role policy JSON document."
}

variable "path" {
  type        = string
  description = "The path to the role."
}

variable "max_session_duration" {
  type        = number
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "permissions_boundary" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the policy that is used to set the permissions boundary for the role."
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "iam_role_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to IAM Role."
}

variable "aws_iam_role_policy_attachments" {
  type        = list(string)
  description = "A list of Amazon Resource Name (ARN) of policies to attach to the role."
}
