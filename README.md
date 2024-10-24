# CloudAMQP RabbitMQ Terraform Module
Terraform module which creates RabbitMQ resources on CloudAMQP.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_cloudamqp"></a> [cloudamqp](#requirement\_cloudamqp) | >= 1.29.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.34.0 |
| <a name="provider_cloudamqp"></a> [cloudamqp](#provider\_cloudamqp) | 1.29.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route.accepter_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.aws_vpc_peering](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [cloudamqp_extra_disk_size.resize_disk](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/extra_disk_size) | resource |
| [cloudamqp_instance.instance](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/instance) | resource |
| [cloudamqp_integration_log.cloudwatch](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/integration_log) | resource |
| [cloudamqp_integration_log.datadog](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/integration_log) | resource |
| [cloudamqp_integration_metric.cloudwatch_v2](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/integration_metric) | resource |
| [cloudamqp_integration_metric.datadog_v2](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/integration_metric) | resource |
| [cloudamqp_node_actions.restart_01](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/node_actions) | resource |
| [cloudamqp_node_actions.restart_02](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/node_actions) | resource |
| [cloudamqp_node_actions.restart_03](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/node_actions) | resource |
| [cloudamqp_plugin.rabbitmq_plugin](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/plugin) | resource |
| [cloudamqp_plugin_community.rabbitmq_community_plugin](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/plugin_community) | resource |
| [cloudamqp_rabbitmq_configuration.rabbitmq_config](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/rabbitmq_configuration) | resource |
| [cloudamqp_vpc.vpc](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/vpc) | resource |
| [cloudamqp_vpc_peering.vpc_accept_peering](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/vpc_peering) | resource |
| [aws_route_table.route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [cloudamqp_instance.instance_info](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/data-sources/instance) | data source |
| [cloudamqp_nodes.list_nodes](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/data-sources/nodes) | data source |
| [cloudamqp_plugins.plugins](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/data-sources/plugins) | data source |
| [cloudamqp_plugins_community.community_plugins](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/data-sources/plugins_community) | data source |
| [cloudamqp_vpc_info.vpc_info](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/data-sources/vpc_info) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_downtime_resizing_disk"></a> [allow\_downtime\_resizing\_disk](#input\_allow\_downtime\_resizing\_disk) | When resizing the disk, allow cluster downtime if necessary. Default set to false | `bool` | `false` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Api Key required for integration with log/monitoring service | `string` | `null` | no |
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | AWS Access Key ID required for integration with AWS | `string` | `null` | no |
| <a name="input_aws_integration_region"></a> [aws\_integration\_region](#input\_aws\_integration\_region) | Region hosting the AWS logging/monitoring integration service | `string` | `null` | no |
| <a name="input_aws_secret_access_key"></a> [aws\_secret\_access\_key](#input\_aws\_secret\_access\_key) | AWS Secret Access Key required for integration with AWS | `string` | `null` | no |
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | A list of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | AWS VPC CIDR | `string` | `null` | no |
| <a name="input_cloudamqp_rabbitmq_configuration"></a> [cloudamqp\_rabbitmq\_configuration](#input\_cloudamqp\_rabbitmq\_configuration) | Map of arguments to change RabbitMQ config. List of [arguments and their threshold values](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/rabbitmq_configuration#argument-threshold-values) | <pre>object({<br>    channel_max                  = number<br>    connection_max               = number<br>    consumer_timeout             = number<br>    heartbeat                    = number<br>    log_exchange_level           = string<br>    max_message_size             = number<br>    queue_index_embed_msgs_below = number<br>    vm_memory_high_watermark     = number<br>    cluster_partition_handling   = string<br>  })</pre> | <pre>{<br>  "channel_max": 0,<br>  "cluster_partition_handling": "autoheal",<br>  "connection_max": -1,<br>  "consumer_timeout": 7200000,<br>  "heartbeat": 120,<br>  "log_exchange_level": "error",<br>  "max_message_size": 134217728,<br>  "queue_index_embed_msgs_below": 4096,<br>  "vm_memory_high_watermark": 0.81<br>}</pre> | no |
| <a name="input_community_plugins"></a> [community\_plugins](#input\_community\_plugins) | List of RabbitMQ COMMUNITY plugins names to enable in your cluster. See list of [supported community plugins](https://www.cloudamqp.com/docs/cloudamqp-plugins.html#community-plugins) | `list(string)` | `[]` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Controls if CloudAMQP-managed VPC should be created | `bool` | `false` | no |
| <a name="input_create_vpc_peering"></a> [create\_vpc\_peering](#input\_create\_vpc\_peering) | Controls if VPC peering connection should be configured and accepted | `bool` | `false` | no |
| <a name="input_datadog_integration_region"></a> [datadog\_integration\_region](#input\_datadog\_integration\_region) | Region hosting the Datadog logging/monitoring integration service. Should be one of: [us1, us3, us5, eu, eu1] | `string` | `null` | no |
| <a name="input_enable_cloudwatch_log_integration"></a> [enable\_cloudwatch\_log\_integration](#input\_enable\_cloudwatch\_log\_integration) | Controls if AWS Cloudwatch log integration should be configured | `bool` | `false` | no |
| <a name="input_enable_cloudwatch_monitoring_integration"></a> [enable\_cloudwatch\_monitoring\_integration](#input\_enable\_cloudwatch\_monitoring\_integration) | Controls if AWS Cloudwatch monitoring integration should be configured | `bool` | `false` | no |
| <a name="input_enable_datadog_log_integration"></a> [enable\_datadog\_log\_integration](#input\_enable\_datadog\_log\_integration) | Controls if DataDog log integration should be configured | `bool` | `false` | no |
| <a name="input_enable_datadog_monitoring_integration"></a> [enable\_datadog\_monitoring\_integration](#input\_enable\_datadog\_monitoring\_integration) | Controls if DataDog monitoring integration should be configured | `bool` | `false` | no |
| <a name="input_extra_disk_size"></a> [extra\_disk\_size](#input\_extra\_disk\_size) | Extra disk size in GB. Supported values: 0, 25, 50, 100, 250, 500, 1000, 2000 | `number` | `0` | no |
| <a name="input_keep_associated_vpc"></a> [keep\_associated\_vpc](#input\_keep\_associated\_vpc) | Keep associated VPC when deleting instance | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Basic name of CloudAMQP resources | `string` | n/a | yes |
| <a name="input_no_default_alarms"></a> [no\_default\_alarms](#input\_no\_default\_alarms) | Set to true to discard creating default alarms when the instance is created. Can be left out, will then use default value = false | `bool` | `false` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Number of nodes, 1, 3 or 5 depending on plan used. Only needed for legacy plans, will otherwise be computed | `number` | n/a | yes |
| <a name="input_plan"></a> [plan](#input\_plan) | CloudAMQP instance plan. See [available plans](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/guides/info_plan) | `string` | n/a | yes |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of RabbitMQ plugins names to enable in your cluster. See list of [supported plugins](https://www.cloudamqp.com/docs/cloudamqp-plugins.html#rabbitmq-plugins-available-on-cloudamqp) | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to host CloudAMQP instance (and other resources) in. See [instance regions](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/guides/info_region) | `string` | `"amazon-web-services::us-west-2"` | no |
| <a name="input_rmq_version"></a> [rmq\_version](#input\_rmq\_version) | The RabbitMQ version. Can be left out, will then be set to default value used by CloudAMQP API. Available versions (valid on 01.2024): [ 3.12.10, 3.12.6, 3.12.4, 3.12.2, 3.11.18, 3.11.10 ] | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to all resources | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CloudAMQP VPC CIDR | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID. Use this to create your instance in an existing VPC | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudamqp_vpc_info"></a> [cloudamqp\_vpc\_info](#output\_cloudamqp\_vpc\_info) | Object with the information about VPC for a CloudAMQP instance |
| <a name="output_cloudamqp_vpc_peering_status"></a> [cloudamqp\_vpc\_peering\_status](#output\_cloudamqp\_vpc\_peering\_status) | VPC peering status |
| <a name="output_instance_apikey"></a> [instance\_apikey](#output\_instance\_apikey) | API key needed to communicate to CloudAMQP's second API. The second API is used to manage alarms, integration and more. See [full description](https://docs.cloudamqp.com/cloudamqp_api.html) |
| <a name="output_instance_community_plugins"></a> [instance\_community\_plugins](#output\_instance\_community\_plugins) | An array of community plugins |
| <a name="output_instance_external_hostname"></a> [instance\_external\_hostname](#output\_instance\_external\_hostname) | The external hostname for the CloudAMQP instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The identifier (CloudAMQP instance\_id) used as a reference by almost all other resource and data sources |
| <a name="output_instance_internal_hostname"></a> [instance\_internal\_hostname](#output\_instance\_internal\_hostname) | The internal hostname for the CloudAMQP instance |
| <a name="output_instance_nodes"></a> [instance\_nodes](#output\_instance\_nodes) | Object with the information about the node(s) created by CloudAMQP instance |
| <a name="output_instance_plugins"></a> [instance\_plugins](#output\_instance\_plugins) | An array of plugins |
| <a name="output_instance_url"></a> [instance\_url](#output\_instance\_url) | The AMQP URL (uses the internal hostname if the instance was created with VPC). Has the format: amqps://{username}:{password}@{hostname}/{vhost} |
| <a name="output_instance_vhost"></a> [instance\_vhost](#output\_instance\_vhost) | The virtual host used by Rabbit MQ |
