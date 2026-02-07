resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name      = aws_key_pair.jenkins_key.key_name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = aws_key_pair.sonar_key.key_name

  vpc_security_group_ids = [aws_security_group.sonar_sg.id]

  tags = {
    Name = "SonarQube"
  }
}

resource "aws_instance" "nexus" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = aws_key_pair.nexus_key.key_name

  vpc_security_group_ids = [aws_security_group.nexus_sg.id]

  tags = {
    Name = "Nexus"
  }
}

resource "aws_instance" "ansible" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ansible_key.key_name

  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = {
    Name = "Ansible"
  }
}
