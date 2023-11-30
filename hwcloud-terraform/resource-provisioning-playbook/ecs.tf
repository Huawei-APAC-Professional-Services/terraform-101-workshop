# create ecs
data "huaweicloud_availability_zones" "az" {
  region = "ap-southeast-2"
}
data "huaweicloud_compute_flavors" "flavor" {
  availability_zone = data.huaweicloud_availability_zones.az.names[0]
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}
data "huaweicloud_images_image" "image" {
  name        = "Ubuntu 20.04 server 64bit"
  most_recent = true
}
resource "huaweicloud_compute_instance" "ecs" {
  name                  = "ecs-prod"
  image_id              = data.huaweicloud_images_image.image.id
  flavor_id             = data.huaweicloud_compute_flavors.flavor.ids[0]
  availability_zone     = data.huaweicloud_availability_zones.az.names[0]
  security_group_ids    = [huaweicloud_networking_secgroup.secgroup.id]
  system_disk_type      = "SAS"
  system_disk_size      = 40
  user_data =         base64encode(file("user_data.sh"))

  network {
    uuid = module.prod-vpc.private_subnet_id
    fixed_ip_v4  = "10.100.0.101"
  }
  depends_on = [ 
    module.prod-vpc
  ]
}

# create security group
resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = "sec-prod"
}
resource "huaweicloud_networking_secgroup_rule" "http" {
  description       = "Enable for accessing HTTP traffic from outside"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
}
resource "huaweicloud_networking_secgroup_rule" "https" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  description       = "Enable for accessing HTTPS traffic from outside"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
}
resource "huaweicloud_networking_secgroup_rule" "sg_rule_common" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}

# create snat rule adn configure default route
resource "huaweicloud_vpc_route" "vpc_route" { 
  vpc_id         = module.prod-vpc.vpc_id
  destination    = "0.0.0.0/0"
  type           = "peering"
  nexthop        = module.prod_vpc_2_transit_egress_vpc.requester_vpc_peering_id
}

resource "huaweicloud_nat_snat_rule" "egress_snat_rule_for_prod" {
  nat_gateway_id = module.transit-vpc-egress.egress_nat_gw_id
  floating_ip_id = module.transit-vpc-egress.egress_nat_gw_eip
  source_type    = 0
  cidr           = var.prod_vpc_cidr
}

# create the elb listener
resource "huaweicloud_elb_listener" "ingress_elb_listener" {
  name            = "basic"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = module.transit-vpc-ingress.ingress_elb_id

  idle_timeout     = 60
  request_timeout  = 60
  response_timeout = 60
}
resource "huaweicloud_elb_pool" "ingress_elb_pool" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = huaweicloud_elb_listener.ingress_elb_listener.id
}
resource "huaweicloud_elb_l7policy" "ingress_elb_policy" {
  name             = "policy_1"
  listener_id      = huaweicloud_elb_listener.ingress_elb_listener.id
  redirect_pool_id = huaweicloud_elb_pool.ingress_elb_pool.id
}
resource "huaweicloud_elb_member" "ingress_elb_member" {
  address       = "10.100.0.101"
  protocol_port = 80
  pool_id       = huaweicloud_elb_pool.ingress_elb_pool.id
}