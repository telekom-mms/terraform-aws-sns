// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (if not provided, will use project-environment pattern)"
  type        = string
  default     = ""
}


variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "topic_name" {
  description = "Name of the SNS topic (if empty, will use project-environment pattern)"
  type        = string
  default     = ""
}

variable "display_name" {
  description = "The display name for the SNS topic"
  type        = string
  default     = ""
}

variable "policy" {
  description = "The fully-formed AWS IAM policy setup for the SNS topic"
  type        = string
  default     = ""
}

variable "delivery_policy" {
  description = "The SNS delivery policy"
  type        = string
  default     = ""
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default     = "alias/aws/sns" # Best practice: use a custom CMK for higher security
}

variable "fifo_topic" {
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "lambda_subscriptions" {
  description = "List of Lambda subscriptions"
  type = list(object({
    function_arn  = string
    protocol      = string
    filter_policy = optional(string)
  }))
  default = []
}

variable "create_lambda_permissions" {
  description = "Whether to create Lambda permissions for SNS to invoke the function"
  type        = bool
  default     = true
}

variable "sqs_subscriptions" {
  description = "List of SQS subscriptions"
  type = list(object({
    queue_arn            = string
    protocol             = string
    raw_message_delivery = optional(bool, false)
    filter_policy        = optional(string)
  }))
  default = []
}

variable "create_sqs_permissions" {
  description = "Whether to create SQS queue policies for SNS to send messages"
  type        = bool
  default     = true
}

variable "email_subscriptions" {
  description = "List of email subscriptions"
  type = list(object({
    email_address = string
    protocol      = string
    filter_policy = optional(string)
  }))
  default = []
}

variable "http_subscriptions" {
  description = "List of HTTP/HTTPS subscriptions"
  type = list(object({
    endpoint             = string
    protocol             = string
    raw_message_delivery = optional(bool, false)
    filter_policy        = optional(string)
  }))
  default = []
}

variable "sms_subscriptions" {
  description = "List of SMS subscriptions"
  type = list(object({
    phone_number  = string
    protocol      = string
    filter_policy = optional(string)
  }))
  default = []
}

variable "application_subscriptions" {
  description = "List of application subscriptions"
  type = list(object({
    endpoint      = string
    protocol      = string
    filter_policy = optional(string)
  }))
  default = []
}
