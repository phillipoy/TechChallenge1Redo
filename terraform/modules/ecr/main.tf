# Creates ECR repository for the frontend Docker image
resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-frontend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project_name}-frontend-ecr"
    Description = "ECR repository for frontend Docker images"
  }
}

# Creates ECR repository for the backend Docker image
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project_name}-backend-ecr"
    Description = "ECR repository for backend Docker images"
  }
}