# Project name used for consistent resource naming
variable "project_name" {
  type = string
}

# Public subnet used for Jenkins placement
variable "public_subnet_id" {
  type = string
}

# Security group attached to Jenkins
variable "jenkins_sg_id" {
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

# IAM instance profile attached to Jenkins EC2
variable "jenkins_instance_profile_name" {
  type = string
}

# Root volume size for Jenkins builds and Docker images
variable "root_volume_size" {
  type = number
}