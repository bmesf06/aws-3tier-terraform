# Security group for the public ALB
resource "aws_security_group" "alb_public" {
  name        = "sgALB-public"
  description = "Security group for public ALB"
  vpc_id      = aws_vpc.main.id

  # Inbound: HTTP from anywhere
  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: allow all (ALB can reach targets)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgALB-public"
  }
}

# Security group for web instances in private subnets
resource "aws_security_group" "web_private" {
  name        = "sgWeb-private"
  description = "Security group for web servers in private subnets"
  vpc_id      = aws_vpc.main.id

  # Inbound: HTTP only from the ALB SG
  ingress {
    description = "Allow HTTP from ALB security group"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.alb_public.id
    ]
  }

  # Outbound: allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgWeb-private"
  }
}
