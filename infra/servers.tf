resource "google_compute_instance" "etcd" {
  count        = var.NODE_COUNT
  name         = "etcd-${count.index}"
  machine_type = var.GCP_MACHINE_TYPE
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
    ssh-keys = "ubuntu:${file("./id_ed25519.pub")}"
  }
}

resource "google_compute_firewall" "etcd_firewall" {
  name    = "etcdfirewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["2379", "2380"]
  }

  source_ranges = ["0.0.0.0/0"]
}
