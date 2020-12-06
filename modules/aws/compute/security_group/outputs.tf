output "id" {
  description = "The ID of the security group"
  value       = aws_security_group.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the security group"
  value       = aws_security_group.this.arn
}

output "vpc_id" {
  description = "The VPC ID"
  value       = aws_security_group.this.vpc_id
}

output "name" {
  description = "The name of the security group"
  value       = aws_security_group.this.name
}
