# IAM role that allows ECS tasks to pull ECR images and write CloudWatch logs
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.project_name}-ecs-task-execution-role"
    Description = "Allows ECS Fargate tasks to pull ECR images and write CloudWatch logs"
  }
}

# Attaches AWS managed permissions required for ECS task execution
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM role assigned to the Jenkins EC2 instance
resource "aws_iam_role" "jenkins_role" {
  name = "${var.project_name}-jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.project_name}-jenkins-role"
    Description = "IAM role for Jenkins EC2 server"
  }
}

# Gives Jenkins EC2 broad AWS access during the project
resource "aws_iam_role_policy_attachment" "jenkins_admin_policy" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Instance profile required to attach the Jenkins IAM role to EC2
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "${var.project_name}-jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}

# IAM user used by Jenkins pipeline credentials
resource "aws_iam_user" "jenkins_pipeline_user" {
  name = "${var.project_name}-jenkins-pipeline-user"

  tags = {
    Name        = "${var.project_name}-jenkins-pipeline-user"
    Description = "IAM user for Jenkins CI/CD pipeline"
  }
}

# Allows Jenkins pipeline to push Docker images to ECR
resource "aws_iam_user_policy_attachment" "jenkins_ecr_power_user" {
  user       = aws_iam_user.jenkins_pipeline_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Allows Jenkins pipeline to redeploy ECS services
resource "aws_iam_user_policy_attachment" "jenkins_ecs_full_access" {
  user       = aws_iam_user.jenkins_pipeline_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}