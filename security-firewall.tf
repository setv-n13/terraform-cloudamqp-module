resource "cloudamqp_security_firewall" "firewall_settings" {
  count       = var.add_firewall_rules ? 1 : 0
  instance_id = cloudamqp_instance.instance.id
  dynamic "rules" {
    for_each = length(var.firewall_rules) > 0 ? var.firewall_rules : []
    content {
      ip       = rules.value.ip
      ports    = rules.value.ports
      services = rules.value.services
    }
  }
  timeout = 300
  depends_on = [
    cloudamqp_rabbitmq_configuration.rabbitmq_config,
    cloudamqp_extra_disk_size.resize_disk
  ]
}