
locals {
  tag_name_ec2 = {
    Name = "Component Name"
    details = "EC2 instance - ${var.environment}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
}

resource "aws_instance" "test_ec2_instance" {

  vpc_security_group_ids      = [aws_security_group.public_security_group-ssh.id]
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = aws_subnet.custom_public_subnet.id
  instance_type               = "t2.micro"
  tags                        = local.tag_name_ec2
  associate_public_ip_address = true
  lifecycle {
    #ignore_changes = [ tags["tag1"] ]  # how to apply lifecycle rule on a specific tag using ignore_changes
    ignore_changes = all
  }
}



