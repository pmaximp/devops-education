terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "> 0.9"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }
  }
  required_version = "~>1.12.0"

}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = var.s3_access_key
  secret_key                  = var.s3_secret_key
}