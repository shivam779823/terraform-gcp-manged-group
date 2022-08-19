
resource "google_compute_instance_template" "default" {
  name        = var.vmtemplate
  description = "This template is used to create app server instances."

  tags = ["vm1", "bar"]

  labels = {
    environment = "dev"
  }

  instance_description = "description assigned to instances"
  machine_type         = "e2-medium"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
    // backup the disk every day
    resource_policies = [google_compute_resource_policy.daily_backup.id]
  }



  network_interface {
    network = google_compute_network.vmnet.name
    subnetwork = google_compute_subnetwork.vmsubnet.name
  }

   lifecycle {
    create_before_destroy = true
  }

  
}

data "google_compute_image" "my_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_disk" "foobar" {
  name  = "existing-disk"
  image = data.google_compute_image.my_image.self_link
  size  = 10
  type  = "pd-ssd"
  zone  = "us-central1-a"
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "instance-group-manager"
  instance_template  = google_compute_instance_template.default.id
  base_instance_name = "instance-group-manager"
  zone               = "us-central1-a"
  target_size        = "2"
}