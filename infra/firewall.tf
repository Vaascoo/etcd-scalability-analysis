resource "google_compute_firewall" "etcd_firewall" {
  name    = "etcdfirewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "2379", "2380"]
  }

  source_ranges = ["10.140.0.0/16"]
}
