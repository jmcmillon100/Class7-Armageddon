resource "aws_eip" "dawgs_nat_eip01" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip01"
  }
}

# NATGW
resource "aws_nat_gateway" "dawgs_nat01" {
  allocation_id = aws_eip.dawgs_nat_eip01.id
  subnet_id     = aws_subnet.dawgs_public_subnets[0].id # NAT in a public subnet

  tags = {
    Name = "${local.name_prefix}-nat01"
  }

  depends_on = [aws_internet_gateway.dawgs_igw01]
}