// outputs.tf

output "topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "topic_id" {
  description = "The ID of the SNS topic"
  value       = aws_sns_topic.this.id
}

output "topic_name" {
  description = "The name of the SNS topic"
  value       = aws_sns_topic.this.name
}

output "topic_owner" {
  description = "The AWS Account ID of the SNS topic owner"
  value       = aws_sns_topic.this.owner
}

output "lambda_subscription_arns" {
  description = "ARNs of the Lambda subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.lambda : subscription.arn]
}

output "sqs_subscription_arns" {
  description = "ARNs of the SQS subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.sqs : subscription.arn]
}

output "email_subscription_arns" {
  description = "ARNs of the email subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.email : subscription.arn]
}

output "http_subscription_arns" {
  description = "ARNs of the HTTP/HTTPS subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.http : subscription.arn]
}

output "sms_subscription_arns" {
  description = "ARNs of the SMS subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.sms : subscription.arn]
}

output "application_subscription_arns" {
  description = "ARNs of the application subscriptions"
  value       = [for subscription in aws_sns_topic_subscription.application : subscription.arn]
}
