<!-- BEGIN_TF_DOCS -->


## Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Resources

## Resources

| Name | Type |
|------|------|
| [aws_lambda_permission.sns_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.sms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue_policy.sns_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_application_subscriptions"></a> [application\_subscriptions](#input\_application\_subscriptions) | List of application subscriptions | <pre>list(object({<br/>    endpoint      = string<br/>    protocol      = string<br/>    filter_policy = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enables content-based deduplication for FIFO topics | `bool` | `false` | no |
| <a name="input_create_lambda_permissions"></a> [create\_lambda\_permissions](#input\_create\_lambda\_permissions) | Whether to create Lambda permissions for SNS to invoke the function | `bool` | `true` | no |
| <a name="input_create_sqs_permissions"></a> [create\_sqs\_permissions](#input\_create\_sqs\_permissions) | Whether to create SQS queue policies for SNS to send messages | `bool` | `true` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | The SNS delivery policy | `string` | `""` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the SNS topic | `string` | `""` | no |
| <a name="input_email_subscriptions"></a> [email\_subscriptions](#input\_email\_subscriptions) | List of email subscriptions | <pre>list(object({<br/>    email_address = string<br/>    protocol      = string<br/>    filter_policy = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Boolean indicating whether or not to create a FIFO (first-in-first-out) topic | `bool` | `false` | no |
| <a name="input_http_subscriptions"></a> [http\_subscriptions](#input\_http\_subscriptions) | List of HTTP/HTTPS subscriptions | <pre>list(object({<br/>    endpoint             = string<br/>    protocol             = string<br/>    raw_message_delivery = optional(bool, false)<br/>    filter_policy        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK | `string` | `"alias/aws/sns"` | no |
| <a name="input_lambda_subscriptions"></a> [lambda\_subscriptions](#input\_lambda\_subscriptions) | List of Lambda subscriptions | <pre>list(object({<br/>    function_arn  = string<br/>    protocol      = string<br/>    filter_policy = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The fully-formed AWS IAM policy setup for the SNS topic | `string` | `""` | no |
| <a name="input_sms_subscriptions"></a> [sms\_subscriptions](#input\_sms\_subscriptions) | List of SMS subscriptions | <pre>list(object({<br/>    phone_number  = string<br/>    protocol      = string<br/>    filter_policy = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sqs_subscriptions"></a> [sqs\_subscriptions](#input\_sqs\_subscriptions) | List of SQS subscriptions | <pre>list(object({<br/>    queue_arn            = string<br/>    protocol             = string<br/>    raw_message_delivery = optional(bool, false)<br/>    filter_policy        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | Name of the SNS topic (if empty, will use project-environment pattern) | `string` | `""` | no |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_subscription_arns"></a> [application\_subscription\_arns](#output\_application\_subscription\_arns) | ARNs of the application subscriptions |
| <a name="output_email_subscription_arns"></a> [email\_subscription\_arns](#output\_email\_subscription\_arns) | ARNs of the email subscriptions |
| <a name="output_http_subscription_arns"></a> [http\_subscription\_arns](#output\_http\_subscription\_arns) | ARNs of the HTTP/HTTPS subscriptions |
| <a name="output_lambda_subscription_arns"></a> [lambda\_subscription\_arns](#output\_lambda\_subscription\_arns) | ARNs of the Lambda subscriptions |
| <a name="output_sms_subscription_arns"></a> [sms\_subscription\_arns](#output\_sms\_subscription\_arns) | ARNs of the SMS subscriptions |
| <a name="output_sqs_subscription_arns"></a> [sqs\_subscription\_arns](#output\_sqs\_subscription\_arns) | ARNs of the SQS subscriptions |
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | The ARN of the SNS topic |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | The ID of the SNS topic |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | The name of the SNS topic |
| <a name="output_topic_owner"></a> [topic\_owner](#output\_topic\_owner) | The AWS Account ID of the SNS topic owner |
<!-- END_TF_DOCS -->