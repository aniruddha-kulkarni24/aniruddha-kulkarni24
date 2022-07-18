variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "Avalanche-eks-cluster"
}

# Subnet Variable Define
variable "avalanche-1a" {
  description = "This is Avalanche subnet"
  type        = string
  default     = "Coindelta-NonProd-Prv-Avalanche-1a"
}

# Subnet Variable Define
variable "avalanche-1b" {
  description = "This is Avalanche subnet"
  type        = string
  default     = "Coindelta-NonProd-Prv-Avalanche-1b"
}


# VPC Variable Define
variable "vpc_name" {
  description = "This is CoindeltaNonProd VPC"
  type        = string
  default     = "Coindelta-NonProd"
}


