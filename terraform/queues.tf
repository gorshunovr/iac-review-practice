resource "aws_sqs_queue" "events" {
  for_each                  = toset(var.queue_names)
  name                      = "${var.environment}-${each.key}"
  message_retention_seconds = 345600
  sqs_managed_sse_enabled   = true
}
