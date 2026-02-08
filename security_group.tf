resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "sonar_sg" {
  name   = "sonar_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "nexus_sg" {
  name   = "nexus_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "ansible_sg" {
  name   = "ansible_sg"
  vpc_id = aws_vpc.main.id
}

# SSH (privremeno sa svih IP-jeva)
resource "aws_security_group_rule" "ssh_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansible_sg.id
}

# Jenkins ↔ Sonar
resource "aws_security_group_rule" "jenkins_from_sonar" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.sonar_sg.id
}

# Jenkins ↔ Nexus
resource "aws_security_group_rule" "jenkins_from_nexus" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.nexus_sg.id
}

# Jenkins ↔ Ansible
resource "aws_security_group_rule" "jenkins_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# Sonar ↔ Ansible
resource "aws_security_group_rule" "sonar_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sonar_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# Nexus ↔ Ansible
resource "aws_security_group_rule" "nexus_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nexus_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}