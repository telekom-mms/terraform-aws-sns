// locals.tf

locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : "${var.project_name}-${var.environment}"
  topic_name  = var.topic_name != "" ? var.topic_name : "${local.name_prefix}-topic"

  # Add .fifo suffix for FIFO topics
  final_topic_name = var.fifo_topic ? "${local.topic_name}.fifo" : local.topic_name

  common_tags = merge(var.tags, {
    "Project"       = var.project_name
    "Environment"   = var.environment
    "ManagedBy"     = "Terraform"
    "PSA-Compliant" = "true"
  })
}
