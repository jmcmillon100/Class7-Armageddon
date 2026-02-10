# Explanation: dawgs hates exposure—private subnets keep your compute off the public holonet.
resource "aws_instance" "dawgs_ec201_private_bonus" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.dawgs_private_subnets[0].id
  vpc_security_group_ids = [aws_security_group.dawgs_ec2_sg01.id]
  iam_instance_profile   = aws_iam_instance_profile.dawgs_instance_profile01.name
  user_data              = file("${path.module}/user_data.sh")

  tags = {
    Name = "${local.name_prefix}-ec201-private"
  }
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}