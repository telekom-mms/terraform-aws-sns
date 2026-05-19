// examples/basic-sns/main.tf

provider "aws" {
  region = "eu-central-1"
}

module "sns_topic" {
  source = "../../"

  project_name = var.project_name
  environment  = var.environment

  display_name = "My Example SNS Topic"

  email_subscriptions = var.email_subscriptions

  tags = var.tags
}
