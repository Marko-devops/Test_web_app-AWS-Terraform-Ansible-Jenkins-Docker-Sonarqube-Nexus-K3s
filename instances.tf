resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.small"
  key_name      = aws_key_pair.jenkins.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = { Name = "Jenkins" }
}

resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = aws_key_pair.sonar.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.sonar_sg.id]

  tags = { Name = "SonarQube" }
}

resource "aws_instance" "nexus" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = aws_key_pair.nexus.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.nexus_sg.id]

  tags = { Name = "Nexus" }
}

resource "aws_instance" "ansible" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ansible.key_name
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = { Name = "Ansible" }
}
