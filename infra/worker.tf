resource "google_compute_instance" "etcd" {
  count        = var.NODE_COUNT
  name         = "etcd-${count.index}"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  scratch_disk {
    interface = "NVME"
  }

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
