## managed vpc
resource "cloudamqp_vpc" "vpc" {
  count = var.create_vpc && var.vpc_cidr != null ? 1 : 0

  name   = var.name
  region = var.region
  subnet = var.vpc_cidr
  tags   = var.tags
}

## vpc peering
#### additional vpc information
data "cloudamqp_vpc_info" "vpc_info" {
  count  = var.create_vpc && var.vpc_cidr != null ? 1 : 0
  vpc_id = cloudamqp_vpc.vpc[0].id
}
#### aws - create peering request
resource "aws_vpc_peering_connection" "aws_vpc_peering" {
  count    = var.create_vpc_peering && var.aws_vpc_id != null ? 1 : 0
  provider = aws

  vpc_id        = var.aws_vpc_id
  peer_vpc_id   = data.cloudamqp_vpc_info.vpc_info[0].id
  peer_owner_id = data.cloudamqp_vpc_info.vpc_info[0].owner_id
  tags          = var.aws_tags
}
#### cloudamqp - accept the peering request
resource "cloudamqp_vpc_peering" "vpc_accept_peering" {
  count = var.create_vpc_peering ? 1 : 0

  vpc_id     = var.create_vpc == false && var.vpc_id != null ? var.vpc_id : cloudamqp_vpc.vpc[0].id
  peering_id = aws_vpc_peering_connection.aws_vpc_peering[0].id
  sleep      = 30
}
#### aws - retrieve the route table created in aws
data "aws_route_table" "route_table" {
  count    = var.create_vpc_peering && var.vpc_cidr != null ? 1 : 0
  provider = aws

  vpc_id = var.aws_vpc_id

  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}
#### aws - once the peering request is accepted, configure routing table on accepter to allow traffic
resource "aws_route" "accepter_route" {
  count    = var.create_vpc_peering && var.aws_vpc_id != null ? 1 : 0
  provider = aws

  route_table_id            = data.aws_route_table.route_table[0].route_table_id
  destination_cidr_block    = data.cloudamqp_instance.instance_info.vpc_subnet
  vpc_peering_connection_id = aws_vpc_peering_connection.aws_vpc_peering[0].id

  depends_on = [
    cloudamqp_vpc_peering.vpc_accept_peering,
    cloudamqp_instance.instance,
    cloudamqp_security_firewall.firewall_settings
  ]
}
##