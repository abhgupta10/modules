
locals {
  tag_name_sg = {
    Name = "Component Name"
    details = "Security Group for EC2 - ${var.environment}"
  }
}

resource "aws_security_group" "public_security_group-ssh" {
  name   = "allow limited inward connectivity in public subnet1"
  vpc_id = aws_vpc.aws_custome_vpc.id
  dynamic "ingress" {
    for_each = var.sg_ingress_details
    content {
      description = ingress.value["description"]
      cidr_blocks = ["${ingress.value["cidr"]}"]
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
    }
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
  tags = local.tag_name_sg
}
