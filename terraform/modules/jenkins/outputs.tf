# Public IP address of the Jenkins server
output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}