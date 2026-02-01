# Public Route Table
resource "aws_route_table" "dawgs_public_rt01" {
  vpc_id = aws_vpc.dawgs_vpc01.id

  tags = {
    Name = "${local.name_prefix}-public-rt01"
  }
}

# Private Route Table
resource "aws_route_table" "dawgs_private_rt01" {
  vpc_id = aws_vpc.dawgs_vpc01.id

  tags = {
    Name = "${local.name_prefix}-private-rt01"
  }
}

# Default Public Route
resource "aws_route" "dawgs_public_default_route" {
  route_table_id         = aws_route_table.dawgs_public_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dawgs_igw01.id
}

# Default Private Route
resource "aws_route" "dawgs_private_default_route" {
  route_table_id         = aws_route_table.dawgs_private_rt01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.dawgs_nat01.id
}

# Public Route Associations
resource "aws_route_table_association" "dawgs_public_rta" {
  count          = length(aws_subnet.dawgs_public_subnets)
  subnet_id      = aws_subnet.dawgs_public_subnets[count.index].id
  route_table_id = aws_route_table.dawgs_public_rt01.id
}

# Private Route Associations
resource "aws_route_table_association" "dawgs_private_rta" {
  count          = length(aws_subnet.dawgs_private_subnets)
  subnet_id      = aws_subnet.dawgs_private_subnets[count.index].id
  route_table_id = aws_route_table.dawgs_private_rt01.id
}