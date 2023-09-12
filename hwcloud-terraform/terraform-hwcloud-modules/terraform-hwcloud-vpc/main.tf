## VPC
resource "huaweicloud_vpc" "default" {
  name = var.name
  cidr = var.vpc_cidr
}

## Subnet
resource "huaweicloud_vpc_subnet" "private_subnet" {
  count         = length(var.private_subnet_cidr) > 0 ? 1 : 0
  name          = var.private_subnet_name
  cidr          = var.private_subnet_cidr
  gateway_ip    = cidrhost(var.private_subnet_cidr, 1)
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.default.id
}
resource "huaweicloud_vpc_subnet" "ingress_subnet" {
  count         = length(var.ingress_subnet_cidr) > 0 ? 1 : 0 
  name          = var.ingress_subnet_name
  cidr          = var.ingress_subnet_cidr
  gateway_ip    = cidrhost(var.ingress_subnet_cidr, 1)
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.default.id
}
resource "huaweicloud_vpc_subnet" "egress_subnet" {
  count         = length(var.egress_subnet_cidr) > 0 ? 1 : 0
  name          = var.egress_subnet_name
  cidr          = var.egress_subnet_cidr
  gateway_ip    = cidrhost(var.egress_subnet_cidr, 1)
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  vpc_id        = huaweicloud_vpc.default.id
}

## Nat Gateway
resource "huaweicloud_nat_gateway" "egress_nat" {
  count       = length(var.egress_subnet_cidr) > 0 && length(var.egress_nat_gw_name) > 0 ? 1 : 0
  name        = var.egress_nat_gw_name
  spec        = "1"
  vpc_id      = huaweicloud_vpc.default.id
  subnet_id   = huaweicloud_vpc_subnet.egress_subnet[0].id
  depends_on  = [
    huaweicloud_vpc_subnet.egress_subnet,
  ]
}
resource "huaweicloud_vpc_eip" "nat_eip" {
  count         = length(var.egress_subnet_cidr) > 0 && length(var.egress_nat_gw_name) > 0 ? 1 : 0
  publicip {
    type        = "5_bgp"
  }
  bandwidth {
    name        = var.nat_eip_name
    size        = 50
    share_type  = "PER"
    charge_mode = "traffic"
  }
}
resource "huaweicloud_nat_snat_rule" "egress_snat_rule" {
  count          = length(var.egress_subnet_cidr) > 0 && length(var.egress_nat_gw_name) > 0 ? 1 : 0
  nat_gateway_id = huaweicloud_nat_gateway.egress_nat[0].id
  floating_ip_id = huaweicloud_vpc_eip.nat_eip[0].id
  source_type    = 0
  cidr           = var.egress_subnet_cidr
  depends_on     = [
    huaweicloud_nat_gateway.egress_nat,
  ]
}

## ELB
data "huaweicloud_elb_flavors" "flavors" {
  type            = "L7"
  max_connections = 200000
  qps             = 4000
  bandwidth       = 50
}
resource "huaweicloud_elb_loadbalancer" "ingress_elb" {
  count                 = length(var.ingress_subnet_cidr) > 0 && length(var.ingress_elb_name) > 0 ? 1 : 0
  name                  = var.ingress_elb_name
  cross_vpc_backend     = true
  vpc_id                = huaweicloud_vpc.default.id
  ipv4_subnet_id        = huaweicloud_vpc_subnet.ingress_subnet[0].ipv4_subnet_id
  #l4_flavor_id          = "{{ l4_flavor_id }}"
  l7_flavor_id          = data.huaweicloud_elb_flavors.flavors.ids[0]
  availability_zone     = var.elb_az
  iptype                = "5_bgp"
  bandwidth_charge_mode = "traffic"
  sharetype             = "PER"
  bandwidth_size        = 100
  depends_on            = [
    huaweicloud_vpc_subnet.ingress_subnet,
  ]
}