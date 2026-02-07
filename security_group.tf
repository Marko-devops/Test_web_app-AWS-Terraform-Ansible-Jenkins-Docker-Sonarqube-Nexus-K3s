resource "aws_security_group" "jenkins_sg" {
  name = "jenkins_sg"
}

resource "aws_security_group" "sonar_sg" {
  name = "sonar_sg"
}

resource "aws_security_group" "nexus_sg" {
  name = "nexus_sg"
}

resource "aws_security_group" "ansible_sg" {
  name = "ansible_sg"
}

# Jenkins <-> Sonar, Nexus, Ansible
resource "aws_security_group_rule" "jenkins_from_sonar" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.sonar_sg.id
}

resource "aws_security_group_rule" "jenkins_from_nexus" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.nexus_sg.id
}

resource "aws_security_group_rule" "jenkins_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# Sonar <-> Jenkins, Ansible
resource "aws_security_group_rule" "sonar_from_jenkins" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sonar_sg.id
  source_security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "sonar_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sonar_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# Nexus <-> Jenkins, Ansible
resource "aws_security_group_rule" "nexus_from_jenkins" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nexus_sg.id
  source_security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "nexus_from_ansible" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nexus_sg.id
  source_security_group_id = aws_security_group.ansible_sg.id
}

# Ansible <-> svi
resource "aws_security_group_rule" "ansible_from_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.ansible_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
