# Public IP address of the Jenkins server
output "jenkins_public_ip" {
  value = module.jenkins.jenkins_public_ip
}

# Public DNS name of the Application Load Balancer
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

# ECS cluster name
output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

# Frontend ECS service name
output "frontend_service_name" {
  value = module.ecs.frontend_service_name
}

# Backend ECS service name
output "backend_service_name" {
  value = module.ecs.backend_service_name
}