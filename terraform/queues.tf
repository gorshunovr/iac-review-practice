resource "aws_sqs_queue" "events" {
  count                     = length(var.queue_names)
  name                      = "${var.environment}-${var.queue_names[count.index]}"
  message_retention_seconds = 345600
  sqs_managed_sse_enabled   = true
}
