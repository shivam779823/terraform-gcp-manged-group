#vpc
resource "google_compute_network" "vmnet" {
    auto_create_subnetworks = false
    name = var.network
  
}
#subnet
resource "google_compute_subnetwork" "vmsubnet" {
    name = var.subnetwork
    network = google_compute_network.vmnet.id
    private_ip_google_access = true 
    ip_cidr_range = "10.0.1.0/24"
     
}
# reserved IP address
resource "google_compute_global_address" "default" {
  provider = google-beta
  name = "lb-static-ip"
}

#firewall Health checks
resource "google_compute_firewall" "allow-health_checks" {
   name = var.firewall
   network = google_compute_network.vmnet.name
   description = "for health checks"
   direction     = "INGRESS"
   allow {
     protocol = "tcp"
     ports = ["8080","80"]
   }
   target_tags = ["http-server" ]
   source_ranges = [ "130.211.0.0/22", "35.191.0.0/16" ]
}

#allow http traffic
resource "google_compute_firewall" "vmfirewall" {
   name = "vmfirewall"
   network = google_compute_network.vmnet.name
  
   direction     = "INGRESS"
   allow {
     protocol = "tcp"
     ports = ["80","22"]
   }
   target_tags = ["http-server" ]
   source_ranges = [ "0.0.0.0/0" ]
}

