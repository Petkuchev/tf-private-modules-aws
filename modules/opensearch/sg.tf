data "aws_vpc" "devops" {
  id = var.vpc_id
}

resource "aws_security_group" "opensearch_sg" {
  name        = "${var.domain}-opensearch"
  description = "Security group for OpenSearch cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.devops.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.devops.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
