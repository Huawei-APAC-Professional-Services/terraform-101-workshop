output "vpc_id" {
  value       = huaweicloud_vpc.default.id
  description = "VPC ID"
}

output "private_subnet_id" {
  value       = try(huaweicloud_vpc_subnet.private_subnet[0].id, "")
  description = "Private Subnet ID"
}

output "ingress_subnet_id" {
  value       = try(huaweicloud_vpc_subnet.ingress_subnet[0].id, "")
  description = "Ingress Subnet ID"
}

output "egress_subnet_id" {
  value       = try(huaweicloud_vpc_subnet.egress_subnet[0].id, "")
  description = "Egress Subnet ID"
}

output "egress_nat_gw_id" {
  value       = try(huaweicloud_nat_gateway.egress_nat[0].id, "")
  description = "Egress Nat Gateway"
}

output "egress_nat_gw_eip" {
  value       = try(huaweicloud_vpc_eip.nat_eip[0].id, "")
  description = "Egress Nat Gateway EIP"
}

output "ingress_elb_id" {
  value       = try(huaweicloud_elb_loadbalancer.ingress_elb[0].id, "")
  description = "Ingress ELB ID"
}

output "ingress_elb_eip" {
  value       = try(huaweicloud_elb_loadbalancer.ingress_elb[0].ipv4_eip, "")
  description = "EIP address of Ingress ELB"
}