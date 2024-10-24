## logs & monitoring
#### aws integration
resource "cloudamqp_integration_log" "cloudwatch" {
  count             = var.enable_cloudwatch_log_integration ? 1 : 0
  instance_id       = cloudamqp_instance.instance.id
  name              = "cloudwatchlog"
  access_key_id     = var.aws_access_key_id
  secret_access_key = var.aws_secret_access_key
  region            = var.aws_integration_region
}
resource "cloudamqp_integration_metric" "cloudwatch_v2" {
  count             = var.enable_cloudwatch_monitoring_integration ? 1 : 0
  instance_id       = cloudamqp_instance.instance.id
  name              = "cloudwatch_v2"
  access_key_id     = var.aws_access_key_id
  secret_access_key = var.aws_secret_access_key
  region            = var.aws_integration_region
}
#### datadog integration
resource "cloudamqp_integration_log" "datadog" {
  count       = var.enable_datadog_log_integration ? 1 : 0
  instance_id = cloudamqp_instance.instance.id
  name        = "datadog"
  api_key     = var.api_key
  region      = var.datadog_integration_region
  tags        = join(",", var.tags)
}
resource "cloudamqp_integration_metric" "datadog_v2" {
  count       = var.enable_datadog_monitoring_integration ? 1 : 0
  instance_id = cloudamqp_instance.instance.id
  name        = "datadog_v2"
  api_key     = var.api_key
  region      = var.datadog_integration_region
}
##