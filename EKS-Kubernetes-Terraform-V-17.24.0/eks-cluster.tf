module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"
  subnets         = ["subnet-06aa9b1bfa71f3d06", "subnet-0d407dd2f11d51467"]

  vpc_id = data.aws_vpc.Coindelta-NonProd.id

  workers_group_defaults = {
    root_volume_type = "gp2"

  }

  worker_groups = [
    {
      name                          = "node-1"
      instance_type                 = "c5.2xlarge"
      ami                           = "ami-04505e74c0741db8d"
      availability_zone             = "us-east-1a"
      subnet_id                     = "data.aws_subnet.avalanche-1a.id"
      additional_userdata           = "echo nothing"
      additional_security_group_ids = [aws_security_group.node1.id]
    },
    {
      name                          = "node-2"
      instance_type                 = "c5.2xlarge"
      ami                           = "ami-04505e74c0741db8d"
      availability_zone             = "us-east-1b"
      suubnet_id                    = data.aws_subnet.avalanche-1b.id
      additional_userdata           = "echo nothing"
      additional_security_group_ids = [aws_security_group.node2.id]
    },
  ]
}

resource "aws_ebs_volume" "avalanche-claim0_volume" {
 availability_zone = "us-east-1a"
 type              = "gp2"
 size              = 700
 tags = {
    Name = "avalanche-claim0_volume"
  }
}

resource "aws_ebs_volume" "avalanche-claim1_volume" {
 availability_zone = "us-east-1a"
 type              = "gp2"
 size              = 700
 tags = {
    Name = "avalanche-claim1_volume"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
