


terraform {
 backend "gcs" {
   bucket  = "sm-test-p"
   prefix  = "terraform/state"
 }
}