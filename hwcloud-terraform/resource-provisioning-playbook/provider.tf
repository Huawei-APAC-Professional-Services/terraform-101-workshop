terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.55.0" # change it to the latest version
    }
  }
}
provider "huaweicloud" {
  region     = "ap-southeast-3"
}