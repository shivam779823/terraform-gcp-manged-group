resource "random_id" "bucket_prefix" {
  byte_length = 5
  
}

resource "google_storage_bucket" "test-admin" {
  name = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  storage_class = "standard"
  location = "US"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }
}


terraform {
 backend "gcs" {
   bucket  = "${random_id.bucket_prefix.hex}-bucket-tfstate"
   prefix  = "terraform/state"
 }
}