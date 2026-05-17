# Frontend ECR repository URL used by Docker and ECS
output "frontend_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}

# Backend ECR repository URL used by Docker and ECS
output "backend_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}