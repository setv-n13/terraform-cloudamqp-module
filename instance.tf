## instance added to managed vpc
resource "cloudamqp_instance" "instance" {
  name                = var.name
  plan                = var.plan
  region              = var.region
  tags                = var.tags
  vpc_id              = var.create_vpc == false || var.vpc_id != null ? var.vpc_id : cloudamqp_vpc.vpc[0].id
  keep_associated_vpc = var.keep_associated_vpc
}
data "cloudamqp_instance" "instance_info" {
  instance_id = cloudamqp_instance.instance.id
}

## rabbitmq config
resource "cloudamqp_rabbitmq_configuration" "rabbitmq_config" {
  instance_id                  = cloudamqp_instance.instance.id
  channel_max                  = coalesce(var.cloudamqp_rabbitmq_configuration.channel_max, 0)
  connection_max               = coalesce(var.cloudamqp_rabbitmq_configuration.connection_max, -1)
  consumer_timeout             = coalesce(var.cloudamqp_rabbitmq_configuration.consumer_timeout, 7200000)
  heartbeat                    = coalesce(var.cloudamqp_rabbitmq_configuration.heartbeat, 120)
  log_exchange_level           = coalesce(var.cloudamqp_rabbitmq_configuration.log_exchange_level, "info")
  max_message_size             = coalesce(var.cloudamqp_rabbitmq_configuration.max_message_size, 134217728)
  queue_index_embed_msgs_below = coalesce(var.cloudamqp_rabbitmq_configuration.queue_index_embed_msgs_below, 4096)
  vm_memory_high_watermark     = coalesce(var.cloudamqp_rabbitmq_configuration.vm_memory_high_watermark, 0.81)
  cluster_partition_handling   = coalesce(var.cloudamqp_rabbitmq_configuration.cluster_partition_handling, "autoheal")
}
data "cloudamqp_nodes" "list_nodes" {
  instance_id = cloudamqp_instance.instance.id
}
resource "cloudamqp_node_actions" "restart_01" {
  instance_id = cloudamqp_instance.instance.id
  action      = "restart"
  node_name   = data.cloudamqp_nodes.list_nodes.nodes[0].name
  depends_on = [
    cloudamqp_rabbitmq_configuration.rabbitmq_config,
    cloudamqp_extra_disk_size.resize_disk,
    cloudamqp_plugin.rabbitmq_plugin,
    cloudamqp_plugin_community.rabbitmq_community_plugin,
    cloudamqp_security_firewall.firewall_settings,
    cloudamqp_integration_log.cloudwatch,
    cloudamqp_integration_metric.cloudwatch_v2,
    cloudamqp_integration_log.datadog,
    cloudamqp_integration_metric.datadog_v2
  ]
}
resource "cloudamqp_node_actions" "restart_02" {
  # count = length(data.cloudamqp_nodes.list_nodes.nodes) == 3 ? 1 : 0
  count = contains(local.three_node_plans, var.plan) ? 1 : 0
  ##
  instance_id = cloudamqp_instance.instance.id
  action      = "restart"
  node_name   = data.cloudamqp_nodes.list_nodes.nodes[1].name
  depends_on = [
    cloudamqp_node_actions.restart_01,
  ]
}
resource "cloudamqp_node_actions" "restart_03" {
  # count = length(data.cloudamqp_nodes.list_nodes.nodes) == 3 ? 1 : 0
  count = contains(local.three_node_plans, var.plan) ? 1 : 0
  ##
  instance_id = cloudamqp_instance.instance.id
  action      = "restart"
  node_name   = data.cloudamqp_nodes.list_nodes.nodes[2].name
  depends_on = [
    cloudamqp_node_actions.restart_01,
    cloudamqp_node_actions.restart_02,
  ]
}
##

## plugins
resource "cloudamqp_plugin" "rabbitmq_plugin" {
  for_each = {
    for i, plugin in var.plugins :
      try(plugin.name, plugin) => {
        name    = try(plugin.name, plugin)
        enabled = try(plugin.enabled, true)
      }
  }
  instance_id = cloudamqp_instance.instance.id
  name        = each.value.name
  enabled     = each.value.enabled
}
resource "cloudamqp_plugin_community" "rabbitmq_community_plugin" {
  for_each = {
    for i, plugin in var.community_plugins :
      try(plugin.name, plugin) => {
        name    = try(plugin.name, plugin)
        enabled = try(plugin.enabled, true)
      }
  }
  instance_id = cloudamqp_instance.instance.id
  name        = each.value.name
  enabled     = each.value.enabled
}
data "cloudamqp_plugins" "plugins" {
  count       = length(var.plugins) > 0 ? 1 : 0
  instance_id = cloudamqp_instance.instance.id
}
data "cloudamqp_plugins_community" "community_plugins" {
  count       = length(var.community_plugins) > 0 ? 1 : 0
  instance_id = cloudamqp_instance.instance.id
}