output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "vpc_arn" {
  value       = aws_vpc.this.arn
  description = "Amazon Resource Name (ARN) of VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "The CIDR block of the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "The ID list of the public subnets"
}

output "public_subnet_arns" {
  value       = aws_subnet.public.*.arn
  description = "The ARN list of the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "The ID list of the private subnets"
}

output "private_subnet_arns" {
  value       = aws_subnet.private.*.arn
  description = "The ARN list of the private subnets"
}

output "data_subnet_ids" {
  value       = aws_subnet.data.*.id
  description = "The ID list of the data subnets"
}

output "data_subnet_arns" {
  value       = aws_subnet.data.*.arn
  description = "The ARN list of the private subnets"
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the routing table of the public subnets"
}

output "private_route_table_id" {
  value       = aws_route_table.private.*.id
  description = "The ID of the routing table of the private subnets"
}

output "data_route_table_id" {
  value       = aws_route_table.data.*.id
  description = "The ID of the routing table of the data subnets"
}
