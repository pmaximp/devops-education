resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "yc-s3-bucket" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=e4017d77de83fe105604fa7b012bc809a77c2fa2"

  bucket_name = "simple-bucket-${random_string.unique_id.result}"
  max_size    = 1024 * 1024 * 1024
  versioning = {
    enabled = true
  }
  existing_service_account = {
    id         = var.s3_admin_id
    access_key = var.s3_access_key
    secret_key = var.s3_secret_key
  }

}
