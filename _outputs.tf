output "instance_id" {
  description = "The identifier (CloudAMQP instance_id) used as a reference by almost all other resource and data sources"
  value       = cloudamqp_instance.instance.id
}

output "instance_url" {
  description = "The AMQP URL (uses the internal hostname if the instance was created with VPC). Has the format: amqps://{username}:{password}@{hostname}/{vhost}"
  value       = cloudamqp_instance.instance.url
  sensitive   = true
}

output "instance_apikey" {
  description = "API key needed to communicate to CloudAMQP's second API. The second API is used to manage alarms, integration and more. See [full description](https://docs.cloudamqp.com/cloudamqp_api.html)"
  value       = cloudamqp_instance.instance.apikey
  sensitive   = true
}

output "instance_external_hostname" {
  description = "The external hostname for the CloudAMQP instance"
  value       = cloudamqp_instance.instance.host
}

output "instance_internal_hostname" {
  description = "The internal hostname for the CloudAMQP instance"
  value       = cloudamqp_instance.instance.host_internal
}

output "instance_vhost" {
  description = "The virtual host used by Rabbit MQ"
  value       = cloudamqp_instance.instance.vhost
}

output "instance_plugins" {
  description = "An array of plugins"
  value       = try(data.cloudamqp_plugins.plugins[0].plugins, [])
}

output "instance_community_plugins" {
  description = "An array of community plugins"
  value       = try(data.cloudamqp_plugins_community.community_plugins[0].plugins, [])
}

output "instance_nodes" {
  description = "Object with the information about the node(s) created by CloudAMQP instance"
  value       = data.cloudamqp_nodes.list_nodes.nodes
}

output "cloudamqp_vpc_info" {
  description = "Object with the information about VPC for a CloudAMQP instance"
  value       = try(data.cloudamqp_vpc_info.vpc_info, null)
}

output "cloudamqp_vpc_peering_status" {
  description = "VPC peering status"
  value       = try(cloudamqp_vpc_peering.vpc_accept_peering[0].status, null)
}

output "instance_full_data" {
  value     = cloudamqp_instance.instance
  sensitive = true
}

