resource "aws_security_group" "orders_worker" {
  name        = "${var.environment}-orders-worker"
  description = "Orders worker tasks"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTPS from the ALB only"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
