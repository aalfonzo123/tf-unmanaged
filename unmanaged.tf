resource "google_service_account" "backend-sa" {
  account_id   = "backend-sa"
  display_name = "Service Account for backend VMs"
}

resource "google_compute_instance_group" "unmanaged-instance-group" {
  name        = "unmanaged-instance-group"

  instances = [
    google_compute_instance.backend-instance-1.self_link,
    google_compute_instance.backend-instance-2.self_link
  ]

  zone = var.zone
}