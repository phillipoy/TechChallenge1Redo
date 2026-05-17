# Calls the VPC module to create the network foundation
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Creates security groups for ALB, ECS tasks, and Jenkins
module "security_groups" {
  source = "./modules/security-groups"

  project_name  = var.project_name
  vpc_id        = module.vpc.vpc_id
  frontend_port = var.frontend_port
  backend_port  = var.backend_port
  my_ip_cidr    = var.my_ip_cidr
}

# Creates ECR repositories for frontend and backend images
module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}

# Creates IAM permissions for ECS task execution
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

# Creates the Application Load Balancer and ECS target groups
module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  frontend_port     = var.frontend_port
  backend_port      = var.backend_port
}

# Creates ECS cluster, task definitions, services, and autoscaling
module "ecs" {
  source = "./modules/ecs"

  project_name                = var.project_name
  aws_region                  = var.aws_region
  private_subnet_ids          = module.vpc.private_subnet_ids
  ecs_tasks_sg_id             = module.security_groups.ecs_tasks_sg_id
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  frontend_image              = module.ecr.frontend_repository_url
  backend_image               = module.ecr.backend_repository_url
  frontend_port               = var.frontend_port
  backend_port                = var.backend_port
  frontend_target_group_arn   = module.alb.frontend_target_group_arn
  backend_target_group_arn    = module.alb.backend_target_group_arn
}

# Creates Jenkins EC2 automation server
module "jenkins" {
  source = "./modules/jenkins"

  project_name                  = var.project_name
  public_subnet_id              = module.vpc.public_subnet_ids[0]
  jenkins_sg_id                 = module.security_groups.jenkins_sg_id
  ami_id                        = var.ami_id
  key_name                      = var.key_name
  jenkins_instance_profile_name = module.iam.jenkins_instance_profile_name
  root_volume_size              = var.jenkins_root_volume_size
}