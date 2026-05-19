// examples/basic-sns/outputs.tf

output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.sns_topic.topic_arn
}

output "topic_name" {
  description = "Name of the SNS topic"
  value       = module.sns_topic.topic_name
}

output "email_subscription_arns" {
  description = "ARNs of the Email subscriptions"
  value       = module.sns_topic.email_subscription_arns
}
