# Project name used for consistent AWS resource naming
variable "project_name" {
  type = string
}

# AWS region where I am deploying the infrastructure
variable "aws_region" {
  type = string
}

# CIDR block for the main VPC
variable "vpc_cidr" {
  type = string
}

# Public subnet CIDR blocks for ALB and Jenkins
variable "public_subnet_cidrs" {
  type = list(string)
}

# Private subnet CIDR blocks for ECS Fargate services
variable "private_subnet_cidrs" {
  type = list(string)
}

# Availability Zones used for subnet placement
variable "availability_zones" {
  type = list(string)
}

# Frontend container port
variable "frontend_port" {
  type = number
}

# Backend container port
variable "backend_port" {
  type = number
}

# My public IP allowed to access Jenkins
variable "my_ip_cidr" {
  type = string
}

# AMI used for the Jenkins EC2 instance
variable "ami_id" {
  type = string
}

# Existing AWS key pair used for SSH access
variable "key_name" {
  type = string
}

# Root volume size for Jenkins EC2 storage
variable "jenkins_root_volume_size" {
  type = number
}