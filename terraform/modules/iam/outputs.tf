# ECS task execution role ARN used by ECS task definitions
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

# Jenkins instance profile name attached to the EC2 server
output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_profile.name
}