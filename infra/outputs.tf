output "etcd_IPs" {
    value = formatlist("%s = %s", google_compute_instance.etcd.*.name ,google_compute_instance.etcd.*.network_interface.0.network_ip)
}

resource "local_file" "ansible_inventory" {
    filename = "inventory.cfg"
    content = <<EOT

[etcd]
%{ for instance in google_compute_instance.etcd ~}
etcd-${instance.index} ansible_ssh_host=${instance.network_interface.0.access_config.0.nat_ip} ansible_user=ubuntu ansible_python_interpreter=/usr/bin/python3 ansible_connection=ssh
%{ endfor ~}

EOT
}