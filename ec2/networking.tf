locals {
  tag_name_networking = {
    Name = "Component Name"
    details = "Network components - ${var.environment}"
  }
}

#Create a VPC in US east 1
resource "aws_vpc" "aws_custome_vpc" {
  cidr_block = var.cidr_range
  tags       = local.tag_name_networking
}

resource "aws_subnet" "custom_public_subnet" {
  vpc_id                  = aws_vpc.aws_custome_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags                    = local.tag_name_networking

}
