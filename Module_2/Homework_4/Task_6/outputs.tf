output "bucket_name" {
  description = "The name of the bucket."
  value       = module.yc-s3-bucket.bucket_name
}