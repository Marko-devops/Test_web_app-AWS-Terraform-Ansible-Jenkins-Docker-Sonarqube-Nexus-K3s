resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_key"
  public_key = file("~/.ssh/jenkins_key.pub")
}

resource "aws_key_pair" "sonar_key" {
  key_name   = "sonar_key"
  public_key = file("~/.ssh/sonar_key.pub")
}

resource "aws_key_pair" "nexus_key" {
  key_name   = "nexus_key"
  public_key = file("~/.ssh/nexus_key.pub")
}

resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible_key"
  public_key = file("~/.ssh/ansible_key.pub")
}
