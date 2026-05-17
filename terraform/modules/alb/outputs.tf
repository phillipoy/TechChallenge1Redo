# ALB DNS name used to access the application
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

# Frontend target group ARN used by ECS service
output "frontend_target_group_arn" {
  value = aws_lb_target_group.frontend.arn
}

# Backend target group ARN used by ECS service
output "backend_target_group_arn" {
  value = aws_lb_target_group.backend.arn
}