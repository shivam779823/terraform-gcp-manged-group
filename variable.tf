variable "region" {
  type = string
  default = "us-central1"
}

variable "project" {
  
}

# variable "vm" {
#   type = string
# }

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "firewall_health" {
  type = string
}
variable "vmtemplate" {
  type = string
}

variable "backend_bucket" {
  type= string
}

variable "firewall" {
  type= string
}

