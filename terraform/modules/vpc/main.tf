# Creates the primary VPC for the ECS and Jenkins infrastructure
resource "aws_vpc" "main" {

  # Defines the IP address range for the VPC
  cidr_block = var.vpc_cidr

  # Enables DNS hostnames for resources launched in the VPC
  enable_dns_hostnames = true

  # Enables internal DNS resolution within the VPC
  enable_dns_support = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Description = "Primary VPC for ECS Fargate and Jenkins infrastructure"
  }
}

# Provides internet connectivity to public resources
resource "aws_internet_gateway" "main" {

  # Associates the Internet Gateway with the VPC
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Description = "Internet Gateway for public network access"
  }
}

# Creates public subnets for internet-facing resources
resource "aws_subnet" "public" {

  # Creates multiple public subnets across availability zones
  count = length(var.public_subnet_cidrs)

  # Associates subnet with the VPC
  vpc_id = aws_vpc.main.id

  # CIDR block assigned to the subnet
  cidr_block = var.public_subnet_cidrs[count.index]

  # Availability Zone placement
  availability_zone = var.availability_zones[count.index]

  # Automatically assigns public IPs to launched resources
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    Description = "Public subnet for ALB and Jenkins resources"
  }
}

# Creates private subnets for ECS workloads
resource "aws_subnet" "private" {

  # Creates multiple private subnets across availability zones
  count = length(var.private_subnet_cidrs)

  # Associates subnet with the VPC
  vpc_id = aws_vpc.main.id

  # CIDR block assigned to the subnet
  cidr_block = var.private_subnet_cidrs[count.index]

  # Availability Zone placement
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}"
    Description = "Private subnet for ECS Fargate services"
  }
}

# Creates a route table for public subnet traffic
resource "aws_route_table" "public" {

  # Associates the route table with the VPC
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-public-rt"
    Description = "Route table for public internet access"
  }
}

# Creates a default route to the internet
resource "aws_route" "public_internet" {

  # Associates the route with the public route table
  route_table_id = aws_route_table.public.id

  # Routes all outbound traffic to the Internet Gateway
  destination_cidr_block = "0.0.0.0/0"

  # Internet Gateway target
  gateway_id = aws_internet_gateway.main.id
}

# Associates public subnets with the public route table
resource "aws_route_table_association" "public" {

  # Creates associations for each public subnet
  count = length(aws_subnet.public)

  # Public subnet association
  subnet_id = aws_subnet.public[count.index].id

  # Public route table association
  route_table_id = aws_route_table.public.id
}

# Elastic IP used by the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${var.project_name}-nat-eip"
    Description = "Elastic IP for NAT Gateway"
  }
}

# NAT Gateway for private subnet outbound internet access
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.project_name}-nat-gateway"
    Description = "NAT Gateway for private ECS task outbound access"
  }

  depends_on = [aws_internet_gateway.main]
}

# Route table for private subnet outbound traffic
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Description = "Private route table using NAT Gateway for outbound traffic"
  }
}

# Sends private subnet outbound traffic through the NAT Gateway
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# Associates private subnets with the private route table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}