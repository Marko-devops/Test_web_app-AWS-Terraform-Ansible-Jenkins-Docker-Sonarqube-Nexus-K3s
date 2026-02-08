output "public_ips" {
  value = {
    jenkins  = aws_instance.jenkins.public_ip
    sonar    = aws_instance.sonarqube.public_ip
    nexus    = aws_instance.nexus.public_ip
    ansible  = aws_instance.ansible.public_ip
  }
}
