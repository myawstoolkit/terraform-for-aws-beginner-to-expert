provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "TerraformVPC" {
  tags = {
    Name = "TerraformVPC"
  }
  cidr_block = "192.168.0.0/24"
}