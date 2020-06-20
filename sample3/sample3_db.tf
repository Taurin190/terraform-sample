resource "aws_db_subnet_group" "db" {
  name       = "db"
  subnet_ids = [aws_subnet.db-a.id, aws_subnet.db-c.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster" "example3" {
  database_name = var.db_name
  availability_zones = [var.aws_availability_zones["a"], var.aws_availability_zones["c"]]
  engine_mode = "serverless"
  db_subnet_group_name = aws_db_subnet_group.db.id
  master_username = var.db_username
  master_password = var.db_password
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 256
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}