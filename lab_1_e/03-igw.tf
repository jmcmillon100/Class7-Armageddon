

resource "aws_internet_gateway" "dawgs_igw01" {
  vpc_id = aws_vpc.dawgs_vpc01.id

  tags = {
    Name = "${local.name_prefix}-igw01"
  }
}