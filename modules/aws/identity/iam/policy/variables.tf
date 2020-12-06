variable "iam_policy_resource_prefix" {
  type        = string
  description = "The prefix name convention for IAM Policy object."
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment."
}

variable "iam_policy_tier_name" {
  type        = string
  description = "The tier name convention for IAM Policy object."
}

variable "description" {
  type        = string
  description = "Description of the IAM policy."
}

variable "path" {
  type        = string
  description = "Path in which to create the policy."
}

variable "policy" {
  type        = string
  description = "The policy document in a JSON formatted string."
}
