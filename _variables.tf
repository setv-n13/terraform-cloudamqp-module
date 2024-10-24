# variable "create" {
#   description = "Controls if CloudAMQP resources should be created (affects nearly all resources)"
#   type        = bool
#   default     = true
# }
variable "tags" {
  description = "Tags to add to all resources"
  type        = list(string)
  default     = []
}
variable "aws_tags" {
  description = "A list of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "name" {
  description = "Basic name of CloudAMQP resources"
  type        = string
}
variable "region" {
  description = "AWS region to host CloudAMQP instance (and other resources) in. See [instance regions](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/guides/info_region)"
  type        = string
  default     = "amazon-web-services::us-west-2"
}

## instance
variable "plan" {
  description = "CloudAMQP instance plan. See [available plans](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/guides/info_plan)"
  type        = string
}
variable "nodes" {
  description = "Number of nodes, 1, 3 or 5 depending on plan used. Only needed for legacy plans, will otherwise be computed"
  type        = number
  default     = null
}
variable "rmq_version" {
  description = "The RabbitMQ version. Can be left out, will then be set to default value used by CloudAMQP API. Available versions (valid on 01.2024): [ 3.12.10, 3.12.6, 3.12.4, 3.12.2, 3.11.18, 3.11.10 ]"
  type        = string
  default     = null
}
variable "vpc_id" {
  description = "The VPC ID. Use this to create your instance in an existing VPC"
  type        = string
  default     = null
}
variable "no_default_alarms" {
  description = "Set to true to discard creating default alarms when the instance is created. Can be left out, will then use default value = false"
  type        = bool
  default     = false
}
variable "keep_associated_vpc" {
  description = "Keep associated VPC when deleting instance"
  type        = bool
  default     = true
}
variable "extra_disk_size" {
  description = "Extra disk size in GB. Supported values: 0, 25, 50, 100, 250, 500, 1000, 2000"
  type        = number
  default     = 0
}
variable "allow_downtime_resizing_disk" {
  description = "When resizing the disk, allow cluster downtime if necessary. Default set to false"
  type        = bool
  default     = false
}

##  configuration, plugins
variable "plugins" {
  description = "List of RabbitMQ plugins names to enable in your cluster. See list of [supported plugins](https://www.cloudamqp.com/docs/cloudamqp-plugins.html#rabbitmq-plugins-available-on-cloudamqp)"
  type        = list(any)
  default     = []
}
variable "community_plugins" {
  description = "List of RabbitMQ COMMUNITY plugins names to enable in your cluster. See list of [supported community plugins](https://www.cloudamqp.com/docs/cloudamqp-plugins.html#community-plugins)"
  type        = list(any)
  default     = []
}
variable "cloudamqp_rabbitmq_configuration" {
  description = "Map of arguments to change RabbitMQ config. List of [arguments and their threshold values](https://registry.terraform.io/providers/cloudamqp/cloudamqp/latest/docs/resources/rabbitmq_configuration#argument-threshold-values)"
  type = object({
    channel_max                  = number
    connection_max               = number
    consumer_timeout             = number
    heartbeat                    = number
    log_exchange_level           = string
    max_message_size             = number
    queue_index_embed_msgs_below = number
    vm_memory_high_watermark     = number
    cluster_partition_handling   = string
  })
  default = {
    channel_max                  = 0
    connection_max               = -1
    consumer_timeout             = 7200000
    heartbeat                    = 120
    log_exchange_level           = "error"
    max_message_size             = 134217728
    queue_index_embed_msgs_below = 4096
    vm_memory_high_watermark     = 0.81
    cluster_partition_handling   = "autoheal"
  }
}

## vpc
variable "create_vpc" {
  description = "Controls if CloudAMQP-managed VPC should be created"
  type        = bool
  default     = false
}
variable "vpc_cidr" {
  description = "CloudAMQP VPC CIDR"
  type        = string
  default     = null
}

## vpc peering
variable "create_vpc_peering" {
  description = "Controls if VPC peering connection should be configured and accepted"
  type        = bool
  default     = false
}
variable "aws_vpc_id" {
  description = "AWS VPC CIDR"
  type        = string
  default     = null
}

## logging and monitoring integration
#### aws cloudwatch
variable "enable_cloudwatch_log_integration" {
  description = "Controls if AWS Cloudwatch log integration should be configured"
  type        = bool
  default     = false
}
variable "enable_cloudwatch_monitoring_integration" {
  description = "Controls if AWS Cloudwatch monitoring integration should be configured"
  type        = bool
  default     = false
}
variable "aws_integration_region" {
  description = "Region hosting the AWS logging/monitoring integration service"
  type        = string
  default     = null
}
variable "aws_access_key_id" {
  description = "AWS Access Key ID required for integration with AWS"
  type        = string
  default     = null
}
variable "aws_secret_access_key" {
  description = "AWS Secret Access Key required for integration with AWS"
  type        = string
  default     = null
}
####
#### datadog
variable "enable_datadog_log_integration" {
  description = "Controls if DataDog log integration should be configured"
  type        = bool
  default     = false
}
variable "enable_datadog_monitoring_integration" {
  description = "Controls if DataDog monitoring integration should be configured"
  type        = bool
  default     = false
}
variable "datadog_integration_region" {
  description = "Region hosting the Datadog logging/monitoring integration service. Should be one of: [us1, us3, us5, eu, eu1]"
  type        = string
  default     = null
}
variable "api_key" {
  description = "Api Key required for integration with log/monitoring service"
  type        = string
  default     = null
}
####
## firewall
variable "add_firewall_rules" {
  description = "Controls if extra firewall rules should be added for the cluster"
  type        = bool
  default     = false
}
variable "firewall_rules" {
  description = "Api Key required for integration with log/monitoring service"
  type = list(object({
    ip          = string
    ports       = list(number)
    services    = list(string)
    description = string
  }))
  default = []
}