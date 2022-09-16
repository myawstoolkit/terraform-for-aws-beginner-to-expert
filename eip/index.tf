provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-0c2ab3b8efb09f272"
  instance_type = "t2.micro"
}

resource "aws_eip" "myeip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.myeip.public_ip
}