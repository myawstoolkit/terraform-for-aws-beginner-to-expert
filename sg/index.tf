provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "allow_tcp"
  ingress {
    cidr_blocks = [ "0.0.0.0/0"]
    description = "Allow TCP Traffic"
    from_port = 443
    protocol = "TCP"
    to_port = 443
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0"]
    description = "Allow TCP Traffic"
    from_port = 443
    protocol = "TCP"
    to_port = 443
  }
}