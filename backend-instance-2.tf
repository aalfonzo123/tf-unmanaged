resource "google_compute_address" "public-address-2" {
  name         = "public-address-2"
  address_type = "EXTERNAL"
  region       = var.network.region
}

resource "google_compute_instance" "backend-instance-2" {
  name                      = "backend-instance-2"
  machine_type              = "e2-medium"
  zone                      = var.zone
  allow_stopping_for_update = true
  metadata_startup_script = "sudo socat TCP-LISTEN:800,fork FD:1&"

  boot_disk {
    initialize_params {
      size  = "30"
      image = "debian-cloud/debian-11"      
    }
  }

  params {
      resource_manager_tags = {
        (google_tags_tag_value.content-backend.parent) = google_tags_tag_value.content-backend.id
      }
  }
  
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnetwork.id
    access_config {
      nat_ip = google_compute_address.public-address-2.address
    }
  }

  scheduling {
    provisioning_model = "SPOT"
    preemptible                 = true
    automatic_restart           = false
    instance_termination_action = "STOP"
  }

  service_account {
    email  = google_service_account.backend-sa.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [metadata["ssh-keys"]]
  }
}