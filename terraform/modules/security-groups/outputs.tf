# Exposes ALB security group ID
output "alb_sg_id" {
  value = aws_security_group.alb.id
}

# Exposes ECS task security group ID
output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks.id
}

# Exposes Jenkins security group ID
output "jenkins_sg_id" {
  value = aws_security_group.jenkins.id
}