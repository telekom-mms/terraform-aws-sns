// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Data source for current AWS account and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# SNS Topic
# PSA Compliance: Req 1 (encryption)
resource "aws_sns_topic" "this" {
  name                        = local.final_topic_name
  display_name                = var.display_name != "" ? var.display_name : local.final_topic_name
  delivery_policy             = var.delivery_policy
  kms_master_key_id           = var.kms_master_key_id
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = merge(local.common_tags, {
    "Name"          = local.final_topic_name
    "PSA-Compliant" = "true"
  })
}

# Default SNS Policy Document
# PSA Compliance: Req 8 (notification security)
data "aws_iam_policy_document" "default" {
  statement {
    sid       = "AllowPublishFromOwnAccount"
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.this.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "AllowManageFromOwnAccount"
    effect = "Allow"
    actions = [
      "sns:Subscribe",
      "sns:Receive",
      "sns:Publish",
      "sns:ListSubscriptionsByTopic",
      "sns:GetTopicAttributes",
      "sns:DeleteTopic",
      "sns:AddPermission",
      "sns:SetTopicAttributes",
      "sns:RemovePermission"
    ]
    resources = [aws_sns_topic.this.arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  # PSA Compliance: Req 8 (notification security)
  statement {
    sid       = "EnforceSSL"
    effect    = "Deny"
    actions   = ["sns:*"]
    resources = [aws_sns_topic.this.arn]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = var.policy != "" ? var.policy : data.aws_iam_policy_document.default.json
}

# Lambda Subscriptions
resource "aws_sns_topic_subscription" "lambda" {
  count     = length(var.lambda_subscriptions)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = var.lambda_subscriptions[count.index].function_arn

  filter_policy = var.lambda_subscriptions[count.index].filter_policy
}

# Lambda Permissions for SNS
resource "aws_lambda_permission" "sns_invoke" {
  count         = var.create_lambda_permissions ? length(var.lambda_subscriptions) : 0
  statement_id  = "AllowSNSInvoke-${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_subscriptions[count.index].function_arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}

# SQS Subscriptions
resource "aws_sns_topic_subscription" "sqs" {
  count                = length(var.sqs_subscriptions)
  topic_arn            = aws_sns_topic.this.arn
  protocol             = "sqs"
  endpoint             = var.sqs_subscriptions[count.index].queue_arn
  raw_message_delivery = var.sqs_subscriptions[count.index].raw_message_delivery

  filter_policy = var.sqs_subscriptions[count.index].filter_policy
}

# SQS Queue Policies for SNS
# PSA Compliance: Req 8 (notification security)
resource "aws_sqs_queue_policy" "sns_access" {
  count     = var.create_sqs_permissions ? length(var.sqs_subscriptions) : 0
  queue_url = replace(var.sqs_subscriptions[count.index].queue_arn, "arn:aws:sqs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:", "https://sqs.${data.aws_region.current.id}.amazonaws.com/${data.aws_caller_identity.current.account_id}/")

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSNSMessage"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = var.sqs_subscriptions[count.index].queue_arn
        Condition = {
          StringEquals = {
            "aws:SourceArn" = aws_sns_topic.this.arn
          }
        }
      }
    ]
  })
}

# Email Subscriptions
resource "aws_sns_topic_subscription" "email" {
  count     = length(var.email_subscriptions)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email_subscriptions[count.index].email_address

  filter_policy = var.email_subscriptions[count.index].filter_policy
}

# HTTP/HTTPS Subscriptions
# PSA Compliance: Req 8 (notification security)
resource "aws_sns_topic_subscription" "http" {
  count                = length(var.http_subscriptions)
  topic_arn            = aws_sns_topic.this.arn
  protocol             = var.http_subscriptions[count.index].protocol
  endpoint             = var.http_subscriptions[count.index].endpoint
  raw_message_delivery = var.http_subscriptions[count.index].raw_message_delivery

  filter_policy = var.http_subscriptions[count.index].filter_policy
}

# SMS Subscriptions
resource "aws_sns_topic_subscription" "sms" {
  count     = length(var.sms_subscriptions)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sms"
  endpoint  = var.sms_subscriptions[count.index].phone_number

  filter_policy = var.sms_subscriptions[count.index].filter_policy
}

# Application Subscriptions
resource "aws_sns_topic_subscription" "application" {
  count     = length(var.application_subscriptions)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "application"
  endpoint  = var.application_subscriptions[count.index].endpoint

  filter_policy = var.application_subscriptions[count.index].filter_policy
}
