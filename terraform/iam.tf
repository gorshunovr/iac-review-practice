data "aws_iam_policy_document" "ecs_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "orders_worker" {
  name               = "${var.environment}-orders-worker"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume.json
}

data "aws_iam_policy_document" "orders_worker" {
  statement {
    actions   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
    resources = aws_sqs_queue.events[*].arn
  }
}

resource "aws_iam_role_policy" "orders_worker" {
  name   = "orders-worker"
  role   = aws_iam_role.orders_worker.id
  policy = data.aws_iam_policy_document.orders_worker.json
}
