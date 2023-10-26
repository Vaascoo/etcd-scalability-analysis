resource "google_compute_instance" "dispatcher" {
  count        = 1
  name         = "dispatcher"
  machine_type = var.GCP_ADMIN_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2304-lunar-amd64-v20230919"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("keys/id_ed25519.pub")}"
  }
}
