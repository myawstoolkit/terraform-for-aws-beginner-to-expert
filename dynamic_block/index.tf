provider "aws" {
  region = "us-west-2"
}

variable "ingressrules" {
  type = list(number)
  default = [443, 80]
}

variable "egressrules" {
  type = list(number)
  default = [443, 80]
}

resource "aws_instance" "ec2" {
  ami = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "allow_tcp"
  dynamic ingress {
    iterator = port
    for_each = var.ingressrules
    content {
      cidr_blocks = [ "0.0.0.0/0"]
      description = "Allow TCP Traffic"
      from_port = port.value
      protocol = "TCP"
      to_port = port.value
    }
    
  }
  dynamic egress {
    iterator = port
    for_each = var.ingressrules
    content {
      cidr_blocks = [ "0.0.0.0/0"]
      description = "Allow TCP Traffic"
      from_port = port.value
      protocol = "TCP"
      to_port = port.value
    }
  }
}