terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.67.0"
    }
  }
}
provider "huaweicloud" {
  region     = "ap-southeast-3"
}