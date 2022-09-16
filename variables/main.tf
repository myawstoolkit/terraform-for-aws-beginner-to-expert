#  variable
#   └── a value that we can reference and use
#       multiple times 


provider "aws" {
  region = "us-west-2"
}

variable "vpcname" {
  type = string
  default = "myvpc"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "mylist" {
  type =  list(string)
  default = ["Value1", "Value2"]
}

variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

variable "inputname" {
  description = "Set the name of the vpc"
}


resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    #---------------------------------
    # string
    # Name = var.vpcname
    #----------------------------------
    # list
    # Name = var.mylist[0] or [1]
    #----------------------------------
    # map
    # Name = var.mymap["Key1"] or ["Key2"]
    #----------------------------------
    # input 
    # Name = var.inputname
    # --------------------------------
  }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}

variable "mytuple" {
  type = tuple([string, number, string])
  default = [
  "value1",1, "value2"]
}

variable "myobject" {
  type = object({
    name = string,
    port = list(number)
  })
  default = {
    name = "TJ"
    port = [22, 25, 80]
  }
}