resource "google_compute_instance" "etcd" {
    count = var.NODE_COUNT
    name = "etcd-${count.index}"
    machine_type = var.GCP_MACHINE_TYPE
    zone = var.GCP_ZONE

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian.11"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // Include this section to give the VM an external ip address
        }
    }

    metadata = {
      ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
    }
}