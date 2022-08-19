terraform {
 backend "gcs" {
   bucket  = "test-admin"
   prefix  = "terraform/state"
 }
}