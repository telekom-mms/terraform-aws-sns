// examples/basic-sns/variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "example-sns"
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
  default     = "dev"
}

variable "email_subscriptions" {
  description = "List of email addresses to subscribe to the topic"
  type        = list(string)
  default     = ["your-email@example.com"]
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "terraform"
    Project     = "sns-example"
  }
}
