output "eks_id" {
  description = "The name of EKS cluster"
  value       = aws_eks_cluster.this.id
}

output "eks_arn" {
  description = "ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

output "eks_certificate_authority_data" {
  description = "Base64 encoded certificate required to communicate with the EKS cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "eks_endpoint" {
  description = "The endpoint for EKS Kubernetes API"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_identity" {
  description = "Nested attribute containing identity provider information for the cluster"
  value       = aws_eks_cluster.this.identity
}

output "eks_platform_version" {
  description = "EKS platform version for the cluster"
  value       = aws_eks_cluster.this.platform_version
}

output "eks_status" {
  description = "The status of the EKS cluster."
  value       = aws_eks_cluster.this.status
}

output "eks_version" {
  description = "The Kubernetes server version for the cluster"
  value       = aws_eks_cluster.this.version
}
