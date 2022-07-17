data "aws_subnet" "avalanche-1a" {
  filter {
    name   = "tag:Name"
    values = [var.avalanche-1a]
  }
}

data "aws_subnet" "avalanche-1b" {
  filter {
    name   = "tag:Name"
    values = [var.avalanche-1b]
  }
}


data "aws_vpc" "Coindelta-NonProd" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

