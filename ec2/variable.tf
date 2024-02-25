variable "region" {
    type = string
    description = "define the region where you want to create the ec2 instance"
    validation {
     condition     =  contains(["us-east-1"],var.region)
     error_message = "only specific location is allowed"
}
}

variable "cidr_range" {
  type        = string
  description = "variable to define CIDR range"
}

variable "environment" {
  type = string
}

variable "sg_ingress_details" {
  type = map(object(
    {
      protocol    = string
      port        = number
      description = string
      cidr        = string
    }
  ))
  default = {
    SSH = {
      protocol    = "TCP"
      port        = 22
      description = "Security Group for SSH"
      cidr        = "0.0.0.0/0"

    }
    HTTP = {
      protocol    = "TCP"
      port        = 80
      description = "Security Group for HTTP"
      cidr        = "168.1.34.0/24"
    }
    ICMP = {
      protocol    = "TCP"
      port        = 443
      description = "Security Group for ICMP"
      cidr        = "0.0.0.0/0"
    }
  }
}

