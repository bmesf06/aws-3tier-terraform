# Security group for RDS (allow DB port only from web tier)
resource "aws_security_group" "db_private" {
  name        = "sgDB-private"
  description = "Security group for RDS in private subnets"
  vpc_id      = aws_vpc.main.id

  # Inbound: DB port from web tier SG
  ingress {
    description = "Allow DB traffic from web tier"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [
      aws_security_group.web_private.id
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
    Name = "sgDB-private"
  }
}

# DB subnet group using your two private subnets
resource "aws_db_subnet_group" "db_subnets" {
  name = "proj2-db-subnets"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "proj2-db-subnets"
  }
}

# RDS instance (MySQL, single-AZ, free-tier-ish)
resource "aws_db_instance" "app_db" {
  identifier        = "proj2-app-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "appdb"
  username = "appuser"
  password = "AppUserPassw0rd!" # for real use, move to tfvars or env

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.db_private.id]

  publicly_accessible = false
  skip_final_snapshot = true

  backup_retention_period = 1

  tags = {
    Name = "proj2-app-db"
  }
}
