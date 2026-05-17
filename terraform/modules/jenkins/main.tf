# Creates Jenkins EC2 server
resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = "t3.small"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.jenkins_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  iam_instance_profile        = var.jenkins_instance_profile_name

  # Root volume for Jenkins builds, Docker images, and pipeline workspace
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true

    tags = {
      Name        = "${var.project_name}-jenkins-root-volume"
      Description = "Root EBS volume for Jenkins server"
    }
  }

  tags = {
    Name        = "${var.project_name}-jenkins-server"
    Description = "Jenkins automation server"
  }
}