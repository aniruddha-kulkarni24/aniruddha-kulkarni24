
resource "aws_security_group" "node1" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = data.aws_vpc.Coindelta-NonProd.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.11.1.0/24",
    ]
  }
}

resource "aws_security_group" "node2" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = data.aws_vpc.Coindelta-NonProd.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.11.101.0/24",
    ]
  }
}

resource "aws_security_group" "all_node_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = data.aws_vpc.Coindelta-NonProd.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.11.1.0/24",
      "10.11.101.0/24",
      "10.11.0.0/16",
    ]
  }
}
