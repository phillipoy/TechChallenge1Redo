# Project name used for consistent resource naming
variable "project_name" {
  type = string
}

# VPC ID where security groups will be created
variable "vpc_id" {
  type = string
}

# Frontend container port
variable "frontend_port" {
  type = number
}

# Backend container port
variable "backend_port" {
  type = number
}

# Your public IP in CIDR format for Jenkins access
variable "my_ip_cidr" {
  type = string
}