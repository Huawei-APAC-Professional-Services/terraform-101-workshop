terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.56.0" # change the version number to the latest version
    }
  }
}
provider "huaweicloud" {
  region     = "ap-southeast-2"
}