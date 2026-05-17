# Project name used for consistent resource naming
variable "project_name" {
  type = string
}

# VPC ID where target groups are created
variable "vpc_id" {
  type = string
}

# Public subnets used by the ALB
variable "public_subnet_ids" {
  type = list(string)
}

# Security group attached to the ALB
variable "alb_sg_id" {
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