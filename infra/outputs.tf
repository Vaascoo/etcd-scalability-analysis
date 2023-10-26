resource "local_file" "ansible_inventory" {
  filename = "inventory.ini"
  content = templatefile("templates/inventory.ini.tmpl", {
    host_list = flatten([for instance in google_compute_instance.etcd : instance])
  })
}
