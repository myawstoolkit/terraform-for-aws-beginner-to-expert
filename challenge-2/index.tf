provider "aws" {
  region = "us-west-2"
}

# db server  - output the private ip
# web server - fixed public ip (eip)
# create security group 80 443
# run script on web server

variable "ingressrule" {
  type = list(number)
  # default = [ {name = "http", num = 80}, {name = "https", num = 443} ]
  default = [ 80, 443 ]

}

variable "egressrule" {
  type = list(number)
  # default = [ {name = "http", num = 80}, {name = "https", num = 443} ]
  default = [ 80, 443 ]
}

resource "aws_instance" "dbserver" {
  ami = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"
  tags = {
    Name = "DBServer"
  }
}

resource "aws_instance" "webserver" {
  ami = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer"
  }
  security_groups = [aws_security_group.webserversg.name]
  user_data = file("server-script.sh")
}

resource "aws_eip" "webservereip" {
  instance = aws_instance.webserver.id
}

resource "aws_security_group" "webserversg" {
  name = "WebserverSG"
  
  dynamic ingress {
    for_each = var.ingressrule
    iterator = port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp" 
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic egress {
    for_each = var.egressrule
    iterator = port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "dbserverip" {
  value = aws_instance.dbserver.private_ip
}

output "webservereip" {
  value = aws_eip.webservereip.public_ip
}