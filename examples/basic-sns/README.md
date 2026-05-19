# AWS SNS Basic Example

This example demonstrates how to use the AWS SNS module to create a basic SNS topic with email subscriptions.

## Features

- Basic SNS topic
- Email subscriptions

## Usage

1.  Copy this example to your project.
2.  Update `variables.tf` with your specific values, especially `email_subscriptions`.
3.  Initialize and apply:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```
4.  Confirm the subscription via the email sent to the provided address.

## Variables

See `variables.tf` for all configurable options.

## Outputs

- `topic_arn`: ARN of the created SNS topic.
- `topic_name`: Name of the created SNS topic.
- `email_subscription_arns`: ARNs of the email subscriptions.

## Requirements

- AWS CLI configured
- Terraform >= 1.0
