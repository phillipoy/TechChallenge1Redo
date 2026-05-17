# Exposes the VPC ID for use in other modules
output "vpc_id" {
  value = aws_vpc.main.id
}

# Exposes public subnet IDs for ALB and Jenkins resources
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

# Exposes private subnet IDs for ECS services
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}