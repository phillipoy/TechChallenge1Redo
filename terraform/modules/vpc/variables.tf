# Project naming convention used across resources
variable "project_name" {}

# CIDR block assigned to the VPC
variable "vpc_cidr" {}

# CIDR ranges for public subnets
variable "public_subnet_cidrs" {}

# CIDR ranges for private subnets
variable "private_subnet_cidrs" {}

# Availability Zones used for subnet distribution
variable "availability_zones" {}