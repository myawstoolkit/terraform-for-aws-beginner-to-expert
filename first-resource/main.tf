# 
#   └──  
#       

# provider
#   └── tells TF w/c plugin to use 

# resource
#   └── cloud platform are we going 
#       to create resources

#  tfstate
#   ├── most important file
#   └── keeps track of changes we make  


provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}