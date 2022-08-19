resource "google_compute_network" "vmnet" {
    auto_create_subnetworks = false
    name = var.network
  
}

resource "google_compute_subnetwork" "vmsubnet" {
    name = var.subnetwork
    network = google_compute_network.vmnet.id
    private_ip_google_access = true 
    ip_cidr_range = "10.2.0.0/16"
     
}

resource "google_compute_firewall" "vmfirewall" {
   name = var.firewall
   network = google_compute_network.vmnet.name
   description = "for vm-1 and vm-2"
   allow {
     protocol = "tcp"
     ports = ["8080","80"]
   }
   target_tags = [ "vm1" ]
   source_ranges = [ "10.2.0.0/16" ]
}

