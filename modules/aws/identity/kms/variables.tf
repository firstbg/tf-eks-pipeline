variable "description" {
  type        = string
  description = "The description of the key as viewed in AWS console."
}

variable "key_usage" {
  type        = string
  description = "Specifies the intended use of the key."
}

variable "policy_document" {
  type        = string
  description = "A valid policy JSON document."
}

variable "deletion_window_in_days" {
  type        = number
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days."
}

variable "common_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "kms_key_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to KMS Key."
}

variable "kms_key_resource_prefix" {
  type        = string
  description = "The prefix name convention for KMS Key object."
}

variable "environment_name" {
  type        = string
  description = "The reference name of the current environment."
}

variable "kms_key_tier_name" {
  type        = string
  description = "The tier name convention for KMS Key object."
}
