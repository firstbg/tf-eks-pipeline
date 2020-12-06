output "shared_account_vpc_id" {
  value       = module.shared_account_vpc.vpc_id
  description = "The ID of the VPC in the Shared account"
}

output "shared_account_vpc_arn" {
  value       = module.shared_account_vpc.vpc_arn
  description = "Amazon Resource Name (ARN) in the Shared account"
}

output "shared_account_vpc_cidr_block" {
  value       = module.shared_account_vpc.vpc_cidr_block
  description = "The CIDR block of the VPC in the Shared account"
}

output "shared_account_public_subnet_ids" {
  value       = module.shared_account_vpc.public_subnet_ids
  description = "The ID list of the public subnets in the Shared account"
}

output "shared_account_public_subnet_arns" {
  value       = module.shared_account_vpc.public_subnet_arns
  description = "The ARN list of the public subnets in the Shared account"
}

output "shared_account_private_subnet_ids" {
  value       = module.shared_account_vpc.private_subnet_ids
  description = "The ID list of the private subnets in the Shared account"
}

output "shared_account_private_subnet_arns" {
  value       = module.shared_account_vpc.private_subnet_arns
  description = "The ARN list of the private subnets in the Shared account"
}

output "shared_account_data_subnet_ids" {
  value       = module.shared_account_vpc.data_subnet_ids
  description = "The ID list of the data subnets in the Shared account"
}

output "shared_account_data_subnet_arns" {
  value       = module.shared_account_vpc.data_subnet_arns
  description = "The ARN list of the private subnets in the Shared account"
}
