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

# SSH na Ansible (sa tvog IP-a)
resource "aws_security_group_rule" "ssh_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_ip]
  security_group_id = aws_security_group.ansible_sg.id
}

# Ansible -> svi ostali (SSH + management)
resource "aws_security_group_rule" "ansible_to_jenkins" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

resource "aws_security_group_rule" "ansible_to_sonar" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sonar_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

resource "aws_security_group_rule" "ansible_to_nexus" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nexus_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# EGRESS — internet za SVE
resource "aws_security_group_rule" "jenkins_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "sonar_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sonar_sg.id
}

resource "aws_security_group_rule" "nexus_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nexus_sg.id
}

resource "aws_security_group_rule" "ansible_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansible_sg.id
}
