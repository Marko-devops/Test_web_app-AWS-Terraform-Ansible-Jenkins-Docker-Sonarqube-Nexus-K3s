resource "aws_key_pair" "jenkins" {
  key_name   = "jenkins_key"
  public_key = file("${path.module}/keys/jenkins_key.pub")
}

resource "aws_key_pair" "sonar" {
  key_name   = "sonar_key"
  public_key = file("${path.module}/keys/sonar_key.pub")
}

resource "aws_key_pair" "nexus" {
  key_name   = "nexus_key"
  public_key = file("${path.module}/keys/nexus_key.pub")
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible_key"
  public_key = file("${path.module}/keys/ansible_key.pub")
}

