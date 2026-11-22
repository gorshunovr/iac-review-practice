# Orders Aurora cluster, moving from CDK (OrdersDb stack) to Terraform
resource "aws_rds_cluster" "orders" {
  cluster_identifier      = "orders-aurora"
  engine                  = "aurora-postgresql"
  engine_version          = "16.4"
  master_username         = "orders_admin"
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.orders.name
  vpc_security_group_ids  = [aws_security_group.orders_worker.id]
  storage_encrypted       = true
  skip_final_snapshot     = true
  backup_retention_period = 1

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 4
  }
}

resource "aws_rds_cluster_instance" "writer" {
  cluster_identifier = aws_rds_cluster.orders.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.orders.engine
  engine_version     = aws_rds_cluster.orders.engine_version
}

resource "aws_db_subnet_group" "orders" {
  name       = "orders-aurora"
  subnet_ids = var.private_subnet_ids
}

module "db_alarms_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "orders-db-alarms"
  vpc_id = var.vpc_id
}
