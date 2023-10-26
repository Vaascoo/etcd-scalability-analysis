resource "google_compute_firewall" "etcd_firewall" {
  name    = "etcdfirewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
