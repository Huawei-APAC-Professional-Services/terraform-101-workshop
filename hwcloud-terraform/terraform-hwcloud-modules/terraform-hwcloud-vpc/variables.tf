variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "0.0.0.0/0"
}

# this is by default pointing to Singapore Region DNS, please change it accordingly
variable "primary_dns" {
  description = "The dns for all subnets"
  type        = string
  default     = "100.125.1.250"
}
variable "secondary_dns" {
  description = "The dns for all subnets"
  type        = string
  default     = "100.125.1.251" #Bangkok region
}

variable "private_subnet_name" {
  description = "This is private subnet name"
  type        = string
  default     = "private_subnet"
}
variable "private_subnet_cidr" {
  description = "This is cidr block for private subnet"
  type        = string
  default     = ""
}

variable "ingress_subnet_name" {
  description = "This is ingress subnet name"
  type        = string
  default     = "ingress_subnet"
}
variable "ingress_subnet_cidr" {
  description = "This is cidr block for ingress subnet"
  type        = string
  default     = ""
}

variable "egress_subnet_name" {
  description = "This is egress subnet name"
  type        = string
  default     = "egress_subnet"
}
variable "egress_subnet_cidr" {
  description = "This is cidr block for egress subnet"
  type        = string
  default     = ""
}

variable "egress_nat_gw_name" {
  description = "This is nat gateway for egress as default"
  type        = string
  default     = "egress_nat_gw"
}
variable "nat_eip_name" {
  description = "This is nat eip for egress as default"
  type        = string
  default     = "eip_nat_bgp"
}

variable "ingress_elb_name" {
  description = "This is elb for ingress as default"
  type        = string
  default     = "ingress_elb"
}
variable "elb_az" {
  description = "Availability zone that used to place ELB"
  type        = list(string)
  default     = [""]
}