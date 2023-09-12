terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.49.0" # change the version number to the latest version
    }
  }
}
provider "huaweicloud" {
  region     = "ap-southeast-3"
}